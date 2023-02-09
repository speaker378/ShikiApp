//
//  NewsDetailVideoContentView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 09.02.2023.
//

import UIKit
import WebKit

final class NewsDetailVideoContentView: UIView {

    // MARK: - Private properties
    
    private let videoAspectRatio: CGFloat = 9.0/16.0
    private let contentView = UIView()
    private let linkView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let webPlayerView = WKWebView()
    private let titleLabel: AppLabel = {
        let label = AppLabel(
            title: Texts.OtherMessage.openInYoutube,
            alignment: .left,
            fontSize: AppFont.Style.regularText
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = AppColor.red
        button.setTitle(Texts.OtherMessage.open, for: .normal)
        button.titleLabel?.font = AppFont.Style.blockTitle
        button.contentHorizontalAlignment = .trailing
        button.layer.cornerRadius = Constants.CornerRadius.small
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var tapHandler: (() -> Void)?

    // MARK: - Construction
    
    init(youtubeID: String) {
        super.init(frame: .zero)
        configure(with: youtubeID)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func configureTapHandler(handler: @escaping () -> Void) {
        tapHandler = handler
    }

    // MARK: - Private functions
    
    private func configure(with youtubeID: String) {
        guard let videoURL = URL(string: "\(Constants.Url.baseYoutubeUrl)\(youtubeID)") else { return }
        webPlayerView.navigationDelegate = self
        let request = URLRequest(url: videoURL)
        webPlayerView.load(request)
        button.addTarget(self, action: #selector(openInYoutube), for: .touchUpInside)
    }
    
    private func configureUI() {
        addSubview(contentView)
        contentView.addSubviews([linkView, webPlayerView])
        webPlayerView.addSubview(activityIndicator)
        linkView.addSubviews([titleLabel, button])
        
        linkView.backgroundColor = AppColor.backgroundMinor
        configureConstraints()
    }
    
    private func configureConstraints() {
        [contentView, linkView, activityIndicator, webPlayerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: videoAspectRatio,
                constant: Constants.Insets.controlHeight
            ),
            
            linkView.topAnchor.constraint(equalTo: contentView.topAnchor),
            linkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            linkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            linkView.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),

            button.centerYAnchor.constraint(equalTo: linkView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: linkView.trailingAnchor, constant: -Constants.Insets.sideInset),
            button.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),

            titleLabel.centerYAnchor.constraint(equalTo: linkView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: linkView.leadingAnchor, constant: Constants.Insets.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: Constants.Insets.sideInset),
            
            webPlayerView.topAnchor.constraint(equalTo: linkView.bottomAnchor),
            webPlayerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webPlayerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webPlayerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: webPlayerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: webPlayerView.centerXAnchor)
        ])
    }
    
    @objc private func openInYoutube() {
        tapHandler?()
    }
}

// MARK: - WKNavigationDelegate

extension NewsDetailVideoContentView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
