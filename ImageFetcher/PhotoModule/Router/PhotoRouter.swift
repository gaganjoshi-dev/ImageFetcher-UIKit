//
//  PhotoRouter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

protocol PhotoViewRoutingLogic {
    static func photoViewController() -> PhotoViewController
    func presentToViewImageController(source: PhotoViewController, data: PhotoViewModel)
}

protocol PhotoViewDataPassing {
    var dataStore: AlbumModel? { get set }
}

class PhotoRouter: PhotoViewRoutingLogic, PhotoViewDataPassing {

    var dataStore: AlbumModel?

    static func photoViewController() -> PhotoViewController {
        PhotoViewController()
    }

    func presentToViewImageController(source: PhotoViewController, data: PhotoViewModel) {
        let viewController = FullImageViewRouter.fullImageViewViewController()
        viewController.router?.dataStore = data as? PhotoModel

        let navigationController = UINavigationController(rootViewController: viewController)
        source.present(navigationController, animated: true)
    }
}
