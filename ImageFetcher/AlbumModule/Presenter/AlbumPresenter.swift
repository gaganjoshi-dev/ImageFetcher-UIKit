//
//  AlbumPresenter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

final class AlbumPresenter {
    weak var albumViewController: AlbumViewControllerOutput?

    init(albumViewController: AlbumViewControllerOutput) {
        self.albumViewController = albumViewController
    }
}

extension AlbumPresenter: AlbumInteractorOutput {
    func present(result: Result<AlbumModels, Error>) {
        let state: ViewState<[AlbumViewModel]>

        switch result {
        case .success(let albums):
            state = .loaded(albums)
        case .failure(let error):
            state = .failed(message: error.localizedDescription)
        }

        albumViewController?.display(state: state)
    }
}
