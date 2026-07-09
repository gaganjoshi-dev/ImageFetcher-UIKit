//
//  PhotoInteractor.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol PhotoInteractorInput {

    /// <#Description#>
    /// - Parameter album: <#album description#>
    func fetchPhotos(album: AlbumModel?)
}

protocol PhotoInteractorOutput {
    
    /// <#Description#>
    /// - Parameter photos: <#photos description#>
    func presentPhotos(photos: PhotoModels)
}

/// <#Description#>
final class PhotoInteractor {
    
    let interactorOutput: PhotoInteractorOutput
    
    init(presenter: PhotoInteractorOutput) {
        interactorOutput = presenter
    }
}

extension PhotoInteractor: PhotoInteractorInput {
   
    func fetchPhotos(album: AlbumModel?) {
        guard let albumID = album?.id,
              let url = photosURLWithAlbumId(id: String(albumID)) else {
            return
        }
        
        let defaultSession = URLSession(configuration: .default)
        defaultSession.codableTask(with:url) { (photos: [PhotoModel]?, response, error) in
            if let photosList = photos {
                self.interactorOutput.presentPhotos(photos: photosList)
            } else {
                self.interactorOutput.presentPhotos(photos: [])
            }
        }.resume()
    }
    
    private func photosURLWithAlbumId(id: String) -> URL? {
        return URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(id)")
    }
    
}
