//
//  PhotoViewController.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

protocol PhotoViewControllerOutput: AnyObject {
    func displayPhotos(viewModel: [PhotoViewModel])
}

class PhotoViewController: UIViewController {

    var photoInteractorInput: PhotoInteractorInput?
    var router: (PhotoViewRoutingLogic & PhotoViewDataPassing)?

    private var photoView: PhotoView {
        guard let photoView = view as? PhotoView else {
            fatalError("Expected view to be PhotoView")
        }
        return photoView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        router = PhotoRouter()
        photoInteractorInput = PhotoInteractor(presenter: PhotoPresenter(photoViewController: self))
    }

    override func loadView() {
        view = PhotoView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        photoInteractorInput?.fetchPhotos(album: router?.dataStore)
        title = router?.dataStore?.albumTitle
    }
}

extension PhotoViewController: PhotoViewControllerOutput {
    func displayPhotos(viewModel: [PhotoViewModel]) {
        photoView.data(photos: viewModel)
        photoView.photoCollectionViewDataServices?.selectedPhoto = { [weak self] photo in
            guard let self else { return }
            self.router?.presentToViewImageController(source: self, data: photo)
        }
    }
}
