//
//  PhotoView.swift
//  ImageFetcher
//

import UIKit

class PhotoView: UIView {

    let photoCollectionView: UICollectionView
    private(set) var photoCollectionViewDataServices: PhotoCollectionViewDataServices?

    private let spinner = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    private var onRetry: (() -> Void)?

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .zero
        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground

        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = .secondaryLabel
        errorLabel.font = .systemFont(ofSize: 16)
        errorLabel.isHidden = true

        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        retryButton.isHidden = true

        addSubview(photoCollectionView)
        addSubview(spinner)
        addSubview(errorLabel)
        addSubview(retryButton)

        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            photoCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            photoCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            photoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),

            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -24),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        photoCollectionViewDataServices = PhotoCollectionViewDataServices()
        photoCollectionViewDataServices?.registerCells(in: photoCollectionView)
        photoCollectionView.dataSource = photoCollectionViewDataServices
        photoCollectionView.delegate = photoCollectionViewDataServices
    }

    func render(state: ViewState<[PhotoViewModel]>, onRetry: (() -> Void)? = nil) {
        self.onRetry = onRetry

        switch state {
        case .loading:
            photoCollectionView.isHidden = true
            errorLabel.isHidden = true
            retryButton.isHidden = true
            spinner.isHidden = false
            spinner.startAnimating()

        case .loaded(let photos):
            spinner.stopAnimating()
            spinner.isHidden = true
            errorLabel.isHidden = true
            retryButton.isHidden = true
            photoCollectionView.isHidden = false
            photoCollectionViewDataServices?.photos = photos
            photoCollectionView.reloadData()

        case .failed(let message):
            spinner.stopAnimating()
            spinner.isHidden = true
            photoCollectionView.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = message
            retryButton.isHidden = onRetry == nil
        }
    }

    @objc private func retryTapped() {
        onRetry?()
    }
}
