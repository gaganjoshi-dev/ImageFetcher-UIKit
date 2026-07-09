//
//  PhotoView.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//
import UIKit

class PhotoView: UIView {

    let photoCollectionView: UICollectionView
    private let stateOverlay = ViewStateOverlayView()
    private(set) var photoCollectionViewDataServices: PhotoCollectionViewDataServices?

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .zero
        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: frame)
        configurePhotoView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configurePhotoView() {
        backgroundColor = .systemBackground

        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photoCollectionView.backgroundColor = .systemBackground
        stateOverlay.translatesAutoresizingMaskIntoConstraints = false

        addSubview(photoCollectionView)
        addSubview(stateOverlay)

        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            photoCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            photoCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            photoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),

            stateOverlay.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stateOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            stateOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            stateOverlay.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        photoCollectionViewDataServices = PhotoCollectionViewDataServices()
        photoCollectionViewDataServices?.registerCells(in: photoCollectionView)
        photoCollectionView.dataSource = photoCollectionViewDataServices
        photoCollectionView.delegate = photoCollectionViewDataServices
    }

    func render(state: ViewState<[PhotoViewModel]>, retry: (() -> Void)? = nil) {
        stateOverlay.render(state: state, retry: retry)
        photoCollectionView.isHidden = !isLoaded(state)

        if case .loaded(let photos) = state {
            photoCollectionViewDataServices?.photos = photos
            photoCollectionView.reloadData()
        }
    }

    private func isLoaded<T>(_ state: ViewState<T>) -> Bool {
        if case .loaded = state { return true }
        return false
    }
}
