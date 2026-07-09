//
//  AlbumView.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

class AlbumView: UIView {

    let albumTableView = UITableView(frame: .zero, style: .plain)
    private(set) var albumTableViewDataServices: AlbumTableViewDataServices?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAlbumView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAlbumView() {
        backgroundColor = .systemBackground

        albumTableView.translatesAutoresizingMaskIntoConstraints = false
        albumTableView.backgroundColor = .systemBackground
        addSubview(albumTableView)

        NSLayoutConstraint.activate([
            albumTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            albumTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            albumTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            albumTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        albumTableViewDataServices = AlbumTableViewDataServices()
        albumTableViewDataServices?.registerCells(in: albumTableView)
        albumTableView.dataSource = albumTableViewDataServices
        albumTableView.delegate = albumTableViewDataServices
    }

    func data(albums: [AlbumViewModel]) {
        albumTableViewDataServices?.albums = albums
        albumTableView.reloadData()
    }
}
