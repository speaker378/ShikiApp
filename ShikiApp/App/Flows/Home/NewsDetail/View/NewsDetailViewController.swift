//
//  NewsDetailViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let news: NewsModel
    private let scrollView = UIScrollView()
    private let contentView: NewsDetailView
//    private let newsDetailView: NewsDetailView
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 260, height: 160)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return collectionView
//    }()

    // MARK: - Init
    
    init(news: NewsModel, datasource: UICollectionViewDataSource) {
        self.news = news
        contentView = NewsDetailView(
            coverImage: news.image ?? AppImage.ErrorsIcons.nonConnectionIcon,
            title: news.title ?? "no title",
            meta: news.date ?? "no metadata",
            content: news.subtitle ?? "some text",
            collectionDataSource: datasource
        )
//        collectionView.dataSource = datasource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        collectionView.registerCell(NewsDetailCollectionViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        title = Texts.NavigationBarTitles.newsTitle
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
//        contentView.addSubview(newsDetailView)
//        contentView.addSubviews([newsDetailView, collectionView])
        
        configureScrollView()
        configureContentView()
//        configureNewsDetailView()
//        configureCollectionView()
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
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        shareItem.tintColor = AppColor.textMain
        navigationItem.rightBarButtonItem = shareItem
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
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
    
//    private func configureNewsDetailView() {
//        newsDetailView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            newsDetailView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            newsDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            newsDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            newsDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Inset.inset24),
//            newsDetailView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
//        ])
//    }
    
//    private func configureCollectionView() {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: newsDetailView.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 160)
//        ])
//    }
}
