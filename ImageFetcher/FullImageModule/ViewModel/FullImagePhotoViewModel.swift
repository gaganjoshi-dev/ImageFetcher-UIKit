//
//  FullImagePhotoViewModel.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol FullImagePhotoViewModel {
    var fullImagePhotoUrl: String? { get }
}

/// Implematation of `FullImagePhotoViewModel` with `Photo` Model.
extension PhotoModel: FullImagePhotoViewModel {
    var fullImagePhotoUrl: String? {
        return url
    }
}

