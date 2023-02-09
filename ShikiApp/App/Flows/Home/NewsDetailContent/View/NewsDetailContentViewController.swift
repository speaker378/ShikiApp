//
//  NewsDetailContentViewController.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 07.02.2023.
//

import UIKit

final class NewsDetailContentViewController: UIViewController, NewsDetailContentViewInput {

    // MARK: - Private properties
    
    private let presenter: NewsDetailContentViewOutput
    private let isVideoPreview: Bool
    private var imageView: NewsDetailImageContentView?
    private var videoView: NewsDetailVideoContentView?

    // MARK: - Construction
    
    init(presenter: NewsDetailContentViewOutput, URLString: String) {
        self.presenter = presenter
        isVideoPreview = URLString.contains("youtube")
        super.init(nibName: nil, bundle: nil)
        configure(with: URLString)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }

    // MARK: - Private functions
    
    private func configure(with URLString: String) {
        if isVideoPreview {
            guard let youtubeID = presenter.makeYoutubeID(link: URLString) else { return }
            videoView = NewsDetailVideoContentView(youtubeID: youtubeID)
            videoView?.configureTapHandler {
                guard let url = URL(string: "\(Constants.Url.deeplinkYoutubeUrl)\(youtubeID)") else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            view.addSubview(videoView ?? UIView())
        } else {
            imageView = NewsDetailImageContentView(URLString: URLString)
            view.addSubview(imageView ?? UIView())
        }
        configureUI(with: URLString)
    }
    
    private func configureUI(with URLString: String) {
        view.backgroundColor = AppColor.backgroundMain
        if let videoView {
            configureConstraints(contentView: videoView)
        }
        if let imageView {
            configureConstraints(contentView: imageView)
        }
    }
    
    private func configureLeftBarItem() {
        let backItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.back,
            style: .plain,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        backItem.tintColor = AppColor.textMain
        navigationItem.leftBarButtonItem = backItem
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isTranslucent = false
        configureLeftBarItem()
    }
    
    private func configureConstraints(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
