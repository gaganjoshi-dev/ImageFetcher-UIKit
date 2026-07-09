//
//  AlbumInteractor.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

protocol AlbumInteractorInput {
    
    /// <#Description#>
    func fetchAlbums()
}

protocol AlbumInteractorOutput {
    
    /// <#Description#>
    /// - Parameter albums: <#albums description#>
    func presentAlbums(albums: AlbumModels)
}

final class AlbumInteractor {
    
    let interactorOutput: AlbumInteractorOutput
    
    init(presenter: AlbumInteractorOutput) {
        interactorOutput = presenter
    }
}

extension AlbumInteractor: AlbumInteractorInput {
   
    func fetchAlbums() {
        let defaultSession = URLSession(configuration: .default)
        defaultSession.codableTask(with: URL(string: "https://jsonplaceholder.typicode.com/albums")!) { (albums: [AlbumModel]?, response, error) in
            if let albumsList = albums {
                self.interactorOutput.presentAlbums(albums: albumsList)
            } else {
                self.interactorOutput.presentAlbums(albums: [])
            }
        }.resume()
    }
    
}
