//
//  NewsDetailViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class NewsDetailViewController: UIViewController, NewsDetailViewInput {
    
    var news: NewsModel
    
    // MARK: - Private properties
    
    private let viewOutput: NewsDetailViewOutput
    private let scrollView = UIScrollView()
    private let contentView: NewsDetailView

    // MARK: - Init
    
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
    
    // MARK: - Private methods
    
    private func configureUI() {
        title = Texts.NavigationBarTitles.newsTitle
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        configureScrollView()
        configureContentView()
    }
    
    private func configureLeftBarItem() {
        let leadingItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.back,
            style: .plain,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        leadingItem.tintColor = AppColor.textMain
        navigationItem.leftBarButtonItem = leadingItem
    }
    
    private func configureRightBarItem() {
        let trailingItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.share,
            style: .plain,
            target: self,
            action: #selector(trailingItemTapped)
        )
        trailingItem.tintColor = AppColor.textMain
        navigationItem.rightBarButtonItem = trailingItem
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        configureLeftBarItem()
        configureRightBarItem()
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    @objc private func trailingItemTapped() {
        viewOutput.navBarItemTapped()
    }
    
}
