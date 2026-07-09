//
//  FullImageViewPresenter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

/// `FullImageViewPresentationInput <I>` will contain the behavior of present input boundery.
protocol FullImageViewPresentationInput {
    
    /// Present photos
    /// - Parameter photo: Type can be **Photos** or **nil**
    func present(photo: PhotoModel?)
}

/// `FullImageViewPresenter` will contain the `FullImageViewPresentationInput <I>`  methods implementations.
class FullImageViewPresenter: FullImageViewPresentationInput {
    
    weak var viewController: FullImageViewViewControllerOutput?
    
    /// Present photos
    /// - Parameter photo: Type can be **Photos** or **nil**
    func present(photo: PhotoModel?) {
        if let viewModel: FullImagePhotoViewModel = photo {
            viewController?.displayPhotos(viewModel: viewModel)
        }
    }
}
