//
//  FullImageViewPresenter.swift
//  ImageFetcher
//

import UIKit

protocol FullImageViewPresentationInput {
    func present(photo: PhotoModel?)
}

class FullImageViewPresenter: FullImageViewPresentationInput {

    weak var viewController: FullImageViewViewControllerOutput?

    func present(photo: PhotoModel?) {
        guard let photo else { return }
        viewController?.displayPhotos(viewModel: photo)
    }
}
