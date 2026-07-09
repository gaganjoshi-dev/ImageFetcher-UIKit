//
//  PhotoCollectionViewDataServices.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

final class PhotoCollectionViewDataServices: NSObject {

    var photos: [PhotoViewModel] = []
    var selectedPhoto: ((PhotoViewModel) -> Void)?

    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier
        )
    }
}

extension PhotoCollectionViewDataServices: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.data(photo: photos[indexPath.item])
        return cell
    }
}

extension PhotoCollectionViewDataServices: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto?(photos[indexPath.item])
    }
}

extension PhotoCollectionViewDataServices: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width / 2.1, height: width / 2.1 + 40)
    }
}
