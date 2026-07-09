//
//  FullImageViewViewController.swift
//  ImageFetcher
//
//  Created by Gagan joshi on 10/05/21.
//
import UIKit

protocol FullImageViewViewControllerOutput: AnyObject {
    func displayPhotos(viewModel: FullImagePhotoViewModel)
}

class FullImageViewViewController: UIViewController {

    var presenter: FullImageViewPresentationInput?
    var router: (FullImageViewRoutingLogic & FullImageViewDataPassing)?

    private let imageView = UIImageView()

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let presenter = FullImageViewPresenter()
        let router = FullImageViewRouter()
        presenter.viewController = self
        self.presenter = presenter
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureView()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(
            red: 44.0 / 255.0,
            green: 44.0 / 255.0,
            blue: 46.0 / 255.0,
            alpha: 1.0
        )

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureView() {
        let customColor = UIColor(
            red: 44.0 / 255.0,
            green: 44.0 / 255.0,
            blue: 46.0 / 255.0,
            alpha: 1.0
        )

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = customColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white

        let barItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeTapped))
        barItem.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        navigationItem.rightBarButtonItem = barItem

        presenter?.present(photo: router?.dataStore)
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

extension FullImageViewViewController: FullImageViewViewControllerOutput {

    func displayPhotos(viewModel: FullImagePhotoViewModel) {
        if let photoURL = viewModel.fullImagePhotoUrl {
            imageView.setRemoteImage(from: photoURL, placeholder: UIImage(systemName: "photo"))
        }
    }
}
