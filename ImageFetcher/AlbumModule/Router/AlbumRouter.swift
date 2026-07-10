//
//  AlbumRouter.swift
//  ImageFetcher
//

import UIKit

protocol AlbumViewRoutingLogic {
    func presentToViewImageController(source: AlbumViewController, data: AlbumViewModel)
}

class AlbumRouter: AlbumViewRoutingLogic {
    func presentToViewImageController(source: AlbumViewController, data: AlbumViewModel) {
        let viewController = PhotoRouter.photoViewController()
        viewController.router?.dataStore = data as? AlbumModel
        source.navigationController?.pushViewController(viewController, animated: true)
    }
}
