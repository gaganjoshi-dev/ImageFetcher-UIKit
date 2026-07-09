//
//  RemotePhotoURL.swift
//  ImageFetcher
//

import Foundation

enum RemotePhotoURL {
    /// JSONPlaceholder still returns dead `via.placeholder.com` image URLs.
    /// `dummyimage.com` accepts the same path shape and returns PNG data UIImage can decode.
    static func resolvedURL(from urlString: String?) -> URL? {
        guard var urlString else { return nil }

        if urlString.contains("via.placeholder.com") {
            urlString = urlString.replacingOccurrences(
                of: "via.placeholder.com",
                with: "dummyimage.com"
            )
        }

        return URL(string: urlString)
    }
}
