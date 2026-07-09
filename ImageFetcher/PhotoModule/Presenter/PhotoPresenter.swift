//
//  PhotoPresenter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

/// <#Description#>
final class PhotoPresenter {
    
    weak var photoViewController: PhotoViewControllerOutput?
    
    init(photoViewController: PhotoViewControllerOutput) {
        self.photoViewController = photoViewController
    }
}


extension PhotoPresenter: PhotoInteractorOutput {
    
    func presentPhotos(photos: PhotoModels) {
        photoViewController?.displayPhotos(viewModel: photos)
    }
}
