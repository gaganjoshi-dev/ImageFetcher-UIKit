//
//  AlbumView.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

class AlbumView: UIView {

    let albumTableView = UITableView(frame: .zero, style: .plain)
    private let stateOverlay = ViewStateOverlayView()
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
        stateOverlay.translatesAutoresizingMaskIntoConstraints = false

        addSubview(albumTableView)
        addSubview(stateOverlay)

        NSLayoutConstraint.activate([
            albumTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            albumTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            albumTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            albumTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            stateOverlay.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stateOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            stateOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            stateOverlay.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        albumTableViewDataServices = AlbumTableViewDataServices()
        albumTableViewDataServices?.registerCells(in: albumTableView)
        albumTableView.dataSource = albumTableViewDataServices
        albumTableView.delegate = albumTableViewDataServices
    }

    func render(state: ViewState<[AlbumViewModel]>, retry: (() -> Void)? = nil) {
        stateOverlay.render(state: state, retry: retry)
        albumTableView.isHidden = !isLoaded(state)

        if case .loaded(let albums) = state {
            albumTableViewDataServices?.albums = albums
            albumTableView.reloadData()
        }
    }

    private func isLoaded<T>(_ state: ViewState<T>) -> Bool {
        if case .loaded = state { return true }
        return false
    }
}
