//
//  AlbumPresenter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation


/// <#Description#>
final class AlbumPresenter {
    weak var albumViewController: AlbumViewControllerOutput?
    
    init(albumViewController: AlbumViewControllerOutput) {
        self.albumViewController = albumViewController
    }
}


extension AlbumPresenter: AlbumInteractorOutput {
    func presentAlbums(albums: AlbumModels) {
        albumViewController?.displayAlbums(viewModel: albums)
    }
}

