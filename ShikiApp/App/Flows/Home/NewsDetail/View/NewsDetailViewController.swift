//
//  NewsDetailViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - private properties
    
    private let news: NewsModel
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)
//        layout.minimumInteritemSpacing = Constants.Inset.inset8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .magenta
        return collectionView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .yellow
        return scrollView
    }()
    
    private lazy var newsView: NewsDetailView  = {
        let view = NewsDetailView(
            coverImage: news.image ?? AppImage.ErrorsIcons.nonConnectionIcon,
            title: news.title ?? "no title",
            meta: news.date ?? "no metadata",
            content: news.subtitle ?? "some text")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    // TODO: - для теста, удалить это
    private var images = [
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon,
        AppImage.ErrorsIcons.nonConnectionIcon
    ] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Init
    
    init(news: NewsModel) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(NewsDetailCollectionViewCell.self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    // MARK: - Private functions
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(newsView)
        contentView.addSubview(collectionView)
    }
    
    fileprivate func configureLeftBarItem() {
        var backItem: UIBarButtonItem {
            let barButtonItem = UIBarButtonItem(
                image: AppImage.NavigationsBarIcons.back,
                style: .plain,
                target: nil,
                action: #selector(UINavigationController.popViewController(animated:))
            )
            barButtonItem.tintColor = AppColor.textMain
            return barButtonItem
        }
        navigationItem.leftBarButtonItem = backItem
    }
    
    fileprivate func configureRightBarItem() {
        var shareItem: UIBarButtonItem {
            let barButtonItem = UIBarButtonItem(
                image: AppImage.NavigationsBarIcons.share,
                style: .plain,
                target: nil,
                action: #selector(UINavigationController.popViewController(animated:))
            )
            barButtonItem.tintColor = AppColor.textMain
            return barButtonItem
        }
        navigationItem.rightBarButtonItem = shareItem
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.layoutIfNeeded()
        configureLeftBarItem()
        configureRightBarItem()
    }
    
    private func configureCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: newsView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}

extension NewsDetailViewController: UICollectionViewDelegate {

}

extension NewsDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell: NewsDetailCollectionViewCell = collectionView.cell(forRowAt: indexPath),
            images.indices.contains(indexPath.item)
        else { return UICollectionViewCell() }
        cell.configure(image: images[indexPath.item])
        return cell
    }
}
