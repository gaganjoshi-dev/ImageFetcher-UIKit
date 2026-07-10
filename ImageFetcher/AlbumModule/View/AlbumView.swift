//
//  AlbumView.swift
//  ImageFetcher
//

import UIKit

class AlbumView: UIView {

    let albumTableView = UITableView(frame: .zero, style: .plain)
    private(set) var albumTableViewDataServices: AlbumTableViewDataServices?

    private let spinner = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    private var onRetry: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground

        albumTableView.translatesAutoresizingMaskIntoConstraints = false
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

        addSubview(albumTableView)
        addSubview(spinner)
        addSubview(errorLabel)
        addSubview(retryButton)

        NSLayoutConstraint.activate([
            albumTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            albumTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            albumTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            albumTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -24),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        albumTableViewDataServices = AlbumTableViewDataServices()
        albumTableViewDataServices?.registerCells(in: albumTableView)
        albumTableView.dataSource = albumTableViewDataServices
        albumTableView.delegate = albumTableViewDataServices
    }

    func render(state: ViewState<[AlbumViewModel]>, onRetry: (() -> Void)? = nil) {
        self.onRetry = onRetry

        switch state {
        case .loading:
            albumTableView.isHidden = true
            errorLabel.isHidden = true
            retryButton.isHidden = true
            spinner.isHidden = false
            spinner.startAnimating()

        case .loaded(let albums):
            spinner.stopAnimating()
            spinner.isHidden = true
            errorLabel.isHidden = true
            retryButton.isHidden = true
            albumTableView.isHidden = false
            albumTableViewDataServices?.albums = albums
            albumTableView.reloadData()

        case .failed(let message):
            spinner.stopAnimating()
            spinner.isHidden = true
            albumTableView.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = message
            retryButton.isHidden = onRetry == nil
        }
    }

    @objc private func retryTapped() {
        onRetry?()
    }
}
