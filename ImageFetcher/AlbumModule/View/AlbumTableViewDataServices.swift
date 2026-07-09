//
//  AlbumTableViewDataServices.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

final class AlbumTableViewDataServices: NSObject {
    var albums: [AlbumViewModel] = []
    var selectedAlbum: ((AlbumViewModel) -> Void)?

    func registerCells(in tableView: UITableView) {
        tableView.register(
            AlbumTableViewCell.self,
            forCellReuseIdentifier: AlbumTableViewCell.reuseIdentifier
        )
    }
}

extension AlbumTableViewDataServices: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        cell.data(album: albums[indexPath.row])
        return cell
    }
}

extension AlbumTableViewDataServices: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedAlbum?(albums[indexPath.row])
    }
}
