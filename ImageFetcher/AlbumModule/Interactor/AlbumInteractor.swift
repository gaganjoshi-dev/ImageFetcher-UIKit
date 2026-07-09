//
//  AlbumInteractor.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol AlbumInteractorInput {
    func fetchAlbums()
}

protocol AlbumInteractorOutput: AnyObject {
    func present(result: Result<AlbumModels, Error>)
}

final class AlbumInteractor {

    let interactorOutput: AlbumInteractorOutput

    init(presenter: AlbumInteractorOutput) {
        interactorOutput = presenter
    }
}

extension AlbumInteractor: AlbumInteractorInput {

    func fetchAlbums() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
            interactorOutput.present(result: .failure(DataLoadingError.decodingFailed))
            return
        }

        URLSession.shared.codableTask(with: url) { [interactorOutput] (albums: [AlbumModel]?, _, error) in
            if let error {
                interactorOutput.present(result: .failure(error))
                return
            }

            guard let albums else {
                interactorOutput.present(result: .failure(DataLoadingError.decodingFailed))
                return
            }

            interactorOutput.present(result: .success(albums))
        }.resume()
    }
}
