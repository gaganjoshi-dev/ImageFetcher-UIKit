//
//  PhotoInteractor.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol PhotoInteractorInput {
    func fetchPhotos(album: AlbumModel?)
}

protocol PhotoInteractorOutput: AnyObject {
    func present(result: Result<PhotoModels, Error>)
}

final class PhotoInteractor {

    let interactorOutput: PhotoInteractorOutput

    init(presenter: PhotoInteractorOutput) {
        interactorOutput = presenter
    }
}

extension PhotoInteractor: PhotoInteractorInput {

    func fetchPhotos(album: AlbumModel?) {
        guard let albumID = album?.id,
              let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumID)") else {
            interactorOutput.present(result: .failure(DataLoadingError.missingAlbum))
            return
        }

        URLSession.shared.codableTask(with: url) { [interactorOutput] (photos: [PhotoModel]?, _, error) in
            if let error {
                interactorOutput.present(result: .failure(error))
                return
            }

            guard let photos else {
                interactorOutput.present(result: .failure(DataLoadingError.decodingFailed))
                return
            }

            interactorOutput.present(result: .success(photos))
        }.resume()
    }
}
