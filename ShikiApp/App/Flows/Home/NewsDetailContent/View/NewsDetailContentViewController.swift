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
    private let imageView = UIImageViewAsync()

    // MARK: - Construction
    
    init(presenter: NewsDetailContentViewOutput, imageURLString: String) {
        self.imageView.downloadedImage(from: imageURLString)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    // MARK: - Private functions
    
    private func configureUI() {
        // TODO: - подумать какой должен быть заголовок
        title = "@@ Тут должен быть какой-то заголовок? или нет?"
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints()
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
    
    private func configureRightBarItem() {
        let shareItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.share,
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped)
        )
        shareItem.tintColor = AppColor.textMain
        navigationItem.rightBarButtonItem = shareItem
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        configureLeftBarItem()
        configureRightBarItem()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func shareButtonTapped() {
        guard let shareItems = [imageView.image] as? [Any] else { return }
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
}
