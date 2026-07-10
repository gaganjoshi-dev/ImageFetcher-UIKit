//
//  PhotoInteractor.swift
//  ImageFetcher
//

import Foundation

protocol PhotoInteractorInput {
    func fetchPhotos(album: AlbumModel?)
}

protocol PhotoInteractorOutput: AnyObject {
    func present(result: Result<PhotoModels, Error>)
}

final class PhotoInteractor {

    private let output: PhotoInteractorOutput

    init(presenter: PhotoInteractorOutput) {
        output = presenter
    }
}

extension PhotoInteractor: PhotoInteractorInput {
    func fetchPhotos(album: AlbumModel?) {
        guard let albumID = album?.id,
              let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumID)") else {
            output.present(result: .failure(NetworkError.invalidURL))
            return
        }

        NetworkManager.shared.fetch([PhotoModel].self, from: url) { [output] result in
            output.present(result: result)
        }
    }
}
