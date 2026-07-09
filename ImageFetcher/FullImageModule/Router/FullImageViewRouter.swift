//
//  FullImageViewRouter.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

protocol FullImageViewRoutingLogic {
    static func fullImageViewViewController() -> FullImageViewViewController
}

protocol FullImageViewDataPassing {
    var dataStore: PhotoModel? { get set }
}

class FullImageViewRouter: NSObject, FullImageViewRoutingLogic, FullImageViewDataPassing {

    var dataStore: PhotoModel?

    class func fullImageViewViewController() -> FullImageViewViewController {
        FullImageViewViewController()
    }
}
