//
//  AlbumModel.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//



import Foundation

// MARK: - Album
class AlbumModel: Codable {
    let userID, id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }

    init(userID: Int?, id: Int?, title: String?) {
        self.userID = userID
        self.id = id
        self.title = title
    }
}

typealias AlbumModels = [AlbumModel]



