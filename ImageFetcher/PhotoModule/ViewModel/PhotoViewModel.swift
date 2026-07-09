//
//  PhotoViewModel.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol PhotoViewModel {
    var photoTitle: String? { get }
    var photoUrl: String? { get }
    var photoThumbnailURL: String? { get }
}



extension PhotoModel : PhotoViewModel {
    var photoTitle: String? {
        title
    }
    
    var photoUrl: String? {
        url
    }
    
    var photoThumbnailURL: String? {
        thumbnailURL
    }
}


