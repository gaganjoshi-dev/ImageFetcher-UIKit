//
//  PhotoCollectionViewCell.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "photoCollectionViewCell"

    private let photoTitle = UILabel()
    private let photoThumbnailImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoThumbnailImageView.cancelRemoteImageLoad()
        photoTitle.text = nil
    }

    private func setupViews() {
        photoThumbnailImageView.contentMode = .scaleAspectFit
        photoThumbnailImageView.clipsToBounds = true

        photoTitle.font = .systemFont(ofSize: 12)
        photoTitle.textColor = UIColor(red: 0.329, green: 0.094, blue: 0.443, alpha: 1)
        photoTitle.textAlignment = .center
        photoTitle.numberOfLines = 0

        contentView.addSubview(photoThumbnailImageView)
        contentView.addSubview(photoTitle)

        photoThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        photoTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoThumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoThumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoThumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoThumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),

            photoTitle.topAnchor.constraint(equalTo: photoThumbnailImageView.bottomAnchor, constant: 5),
            photoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    func data(photo: PhotoViewModel) {
        photoTitle.text = photo.photoTitle

        guard let photoThumbnail = photo.photoThumbnailURL else { return }
        photoThumbnailImageView.setRemoteImage(from: photoThumbnail, placeholder: UIImage(systemName: "photo"))
    }
}
