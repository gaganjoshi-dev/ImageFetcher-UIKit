//
//  UIImageView+RemoteImage.swift
//  ImageFetcher
//

import UIKit

private var remoteImageURLKey: UInt8 = 0

extension UIImageView {
    func setRemoteImage(from urlString: String?, placeholder: UIImage? = nil) {
        image = placeholder
        objc_setAssociatedObject(self, &remoteImageURLKey, urlString, .OBJC_ASSOCIATION_COPY_NONATOMIC)

        RemoteImageLoader.shared.load(urlString: urlString) { [weak self] loadedImage in
            guard let self else { return }
            guard objc_getAssociatedObject(self, &remoteImageURLKey) as? String == urlString else { return }
            self.image = loadedImage ?? placeholder
        }
    }

    func cancelRemoteImageLoad() {
        objc_setAssociatedObject(self, &remoteImageURLKey, nil, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        image = nil
    }
}
