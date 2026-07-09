//
//  AlbumViewController.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//

import UIKit

protocol AlbumViewControllerOutput: AnyObject {
    func display(state: ViewState<[AlbumViewModel]>)
}

class AlbumViewController: UIViewController {

    var albumInteractorInput: AlbumInteractorInput?
    var router: AlbumViewRoutingLogic?

    private var albumView: AlbumView {
        guard let albumView = view as? AlbumView else {
            fatalError("Expected view to be AlbumView")
        }
        return albumView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        router = AlbumRouter()
        albumInteractorInput = AlbumInteractor(presenter: AlbumPresenter(albumViewController: self))
    }

    override func loadView() {
        view = AlbumView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Albums"
        fetchAlbums()
    }

    private func fetchAlbums() {
        display(state: .loading)
        albumInteractorInput?.fetchAlbums()
    }
}

extension AlbumViewController: AlbumViewControllerOutput {

    func display(state: ViewState<[AlbumViewModel]>) {
        albumView.render(state: state) { [weak self] in
            self?.fetchAlbums()
        }
        albumView.albumTableViewDataServices?.selectedAlbum = { [weak self] album in
            guard let self else { return }
            self.router?.presentToViewImageController(source: self, data: album)
        }
    }
}
