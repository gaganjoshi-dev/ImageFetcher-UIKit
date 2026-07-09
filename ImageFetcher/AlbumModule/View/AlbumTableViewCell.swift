//
//  AlbumTableViewCell.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    static let reuseIdentifier = "albumTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func data(album: AlbumViewModel) {
        textLabel?.text = album.albumTitle
        detailTextLabel?.text = album.albumDiscription
    }
}
