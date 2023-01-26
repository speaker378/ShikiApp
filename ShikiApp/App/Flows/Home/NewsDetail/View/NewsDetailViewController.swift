//
//  NewsDetailViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

final class NewsDetailViewController: UIViewController, NewsDetailViewInput {
    
    var news: NewsModel
    
    // MARK: - Private properties
    
    private let viewOutput: NewsDetailViewOutput
    private let scrollView = UIScrollView()
    private let contentView: NewsDetailView

    // MARK: - Construction
    
    init(presenter: NewsDetailViewOutput, news: NewsModel) {
        self.news = news
        viewOutput = presenter
        contentView = NewsDetailView(news: news)
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
        title = Texts.NavigationBarTitles.newsTitle
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [scrollView, contentView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    @objc private func shareButtonTapped() {
        viewOutput.shareURL()
    }
}
