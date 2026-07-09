//
//  AlbumViewModel.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol AlbumViewModel {
    var albumTitle: String? { get }
    var albumDiscription: String? { get }
}

extension AlbumModel : AlbumViewModel {
    var albumTitle: String? {
        if let albumId = id  {
            return "Album " + String(albumId)
        }
        return ""
    }
       
    var albumDiscription: String? { title }
}
