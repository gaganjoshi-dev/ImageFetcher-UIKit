//
//  ViewStateOverlayView.swift
//  ImageFetcher
//

import UIKit

final class ViewStateOverlayView: UIView {

    private let stackView = UIStackView()
    private let spinner = UIActivityIndicatorView(style: .large)
    private let messageLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    private var retryAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemBackground

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .secondaryLabel
        messageLabel.font = .systemFont(ofSize: 16)

        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)

        stackView.addArrangedSubview(spinner)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(retryButton)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24)
        ])
    }

    func render<T>(state: ViewState<T>, retry: (() -> Void)? = nil) {
        retryAction = retry
        isHidden = false

        switch state {
        case .loading:
            spinner.isHidden = false
            spinner.startAnimating()
            messageLabel.isHidden = true
            retryButton.isHidden = true

        case .loaded:
            isHidden = true
            spinner.stopAnimating()

        case .failed(let message):
            spinner.stopAnimating()
            spinner.isHidden = true
            messageLabel.isHidden = false
            messageLabel.text = message
            retryButton.isHidden = retry == nil
        }
    }

    @objc private func retryTapped() {
        retryAction?()
    }
}
