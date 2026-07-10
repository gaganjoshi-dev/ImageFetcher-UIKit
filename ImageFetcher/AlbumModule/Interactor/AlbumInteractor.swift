//
//  AlbumInteractor.swift
//  ImageFetcher
//

import Foundation

protocol AlbumInteractorInput {
    func fetchAlbums()
}

protocol AlbumInteractorOutput: AnyObject {
    func present(result: Result<AlbumModels, Error>)
}

final class AlbumInteractor {

    private let output: AlbumInteractorOutput

    init(presenter: AlbumInteractorOutput) {
        output = presenter
    }
}

extension AlbumInteractor: AlbumInteractorInput {
    func fetchAlbums() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
            output.present(result: .failure(NetworkError.invalidURL))
            return
        }

        NetworkManager.shared.fetch([AlbumModel].self, from: url) { [output] result in
            output.present(result: result)
        }
    }
}
