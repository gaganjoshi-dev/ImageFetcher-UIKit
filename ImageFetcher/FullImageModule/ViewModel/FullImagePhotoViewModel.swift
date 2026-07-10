//
//  FullImagePhotoViewModel.swift
//  ImageFetcher
//

import Foundation

protocol FullImagePhotoViewModel {
    var fullImagePhotoUrl: String? { get }
}

extension PhotoModel: FullImagePhotoViewModel {
    var fullImagePhotoUrl: String? { url }
}
