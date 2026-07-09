//
//  PhotoPresenter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import Foundation

final class PhotoPresenter {

    weak var photoViewController: PhotoViewControllerOutput?

    init(photoViewController: PhotoViewControllerOutput) {
        self.photoViewController = photoViewController
    }
}

extension PhotoPresenter: PhotoInteractorOutput {
    func present(result: Result<PhotoModels, Error>) {
        let state: ViewState<[PhotoViewModel]>

        switch result {
        case .success(let photos):
            state = .loaded(photos)
        case .failure(let error):
            state = .failed(message: error.localizedDescription)
        }

        photoViewController?.display(state: state)
    }
}
