//
//  NetworkManager.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

// MARK: - URLSession response handlers

extension URLSession {
    func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            DispatchQueue.main.async {
                completionHandler(try? JSONCodable.newJSONDecoder().decode(T.self, from: data), response, nil)
            }
        }
    }
}
