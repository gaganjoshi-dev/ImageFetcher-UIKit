//
//  RemoteImageLoader.swift
//  ImageFetcher
//

import UIKit

final class RemoteImageLoader {
    static let shared = RemoteImageLoader()

    private let cache = NSCache<NSString, UIImage>()
    private let session: URLSession
    private let syncQueue = DispatchQueue(label: "RemoteImageLoader.sync")
    private var inFlightHandlers: [URL: [(UIImage?) -> Void]] = [:]
    private var inFlightTasks: [URL: URLSessionDataTask] = [:]

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 100 * 1024 * 1024
        )
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForRequest = 30
        session = URLSession(configuration: configuration)
        cache.countLimit = 200
    }

    func load(urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString,
              let url = RemotePhotoURL.resolvedURL(from: urlString) else {
            DispatchQueue.main.async { completion(nil) }
            return
        }

        let cacheKey = urlString as NSString
        if let cachedImage = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async { completion(cachedImage) }
            return
        }

        let request = URLRequest(url: url)
        if let cachedResponse = session.configuration.urlCache?.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            cache.setObject(cachedImage, forKey: cacheKey)
            DispatchQueue.main.async { completion(cachedImage) }
            return
        }

        syncQueue.async { [weak self] in
            guard let self else { return }

            if self.inFlightHandlers[url] != nil {
                self.inFlightHandlers[url]?.append(completion)
                return
            }

            self.inFlightHandlers[url] = [completion]

            let task = self.session.dataTask(with: request) { [weak self] data, response, error in
                guard let self else { return }

                let image: UIImage?
                if error == nil,
                   let httpResponse = response as? HTTPURLResponse,
                   (200 ... 299).contains(httpResponse.statusCode),
                   let data,
                   let loadedImage = UIImage(data: data) {
                    self.cache.setObject(loadedImage, forKey: cacheKey)
                    image = loadedImage
                } else {
                    image = nil
                }

                let handlers = self.syncQueue.sync {
                    defer {
                        self.inFlightHandlers[url] = nil
                        self.inFlightTasks[url] = nil
                    }
                    return self.inFlightHandlers[url] ?? []
                }

                DispatchQueue.main.async {
                    handlers.forEach { $0(image) }
                }
            }

            self.inFlightTasks[url] = task
            task.resume()
        }
    }
}
