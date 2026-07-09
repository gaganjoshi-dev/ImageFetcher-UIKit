//
//  ViewState.swift
//  ImageFetcher
//

import Foundation

enum ViewState<T> {
    case loading
    case loaded(T)
    case failed(message: String)
}

enum DataLoadingError: LocalizedError {
    case decodingFailed
    case missingAlbum

    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Could not read the response. Please try again."
        case .missingAlbum:
            return "Album information is missing."
        }
    }
}
