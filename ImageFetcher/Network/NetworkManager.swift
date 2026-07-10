//
//  NetworkManager.swift
//  ImageFetcher
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request."
        case .decodingFailed:
            return "Could not read the response. Please try again."
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()

    private let session = URLSession.shared

    private init() {}

    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            let result: Result<T, Error>

            if let error {
                result = .failure(error)
            } else if let http = response as? HTTPURLResponse, !(200 ... 299).contains(http.statusCode) {
                result = .failure(URLError(.badServerResponse))
            } else if let data, let value = try? JSONDecoder().decode(T.self, from: data) {
                result = .success(value)
            } else {
                result = .failure(NetworkError.decodingFailed)
            }

            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
