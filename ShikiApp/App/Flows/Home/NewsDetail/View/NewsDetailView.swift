//
//  NewsDetailView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import UIKit

final class NewsDetailView: UIView {

    // MARK: - Private properties
    
    private enum Layout {
        
        static let itemWidth: CGFloat = 260
        static let itemHeight: CGFloat = 160
        static let itemSpacing: CGFloat = 8.0
    }
    
    private let coverHeight: CGFloat = 200
    private let sideInset: CGFloat = 16.0
    private let topInset: CGFloat = 4.0
    private let maximumTitleLines = 5
    private let coverImageView = UIImageViewAsync()
    private let gradientLayer = CAGradientLayer()
    private let dataSource: UICollectionViewDataSource?
    private let titleLabel = AppLabel(
        alignment: .left,
        fontSize: AppFont.openSansFont(ofSize: 20, weight: .bold),
        fontСolor: AppColor.textInvert
    )
    private let dateLabel = AppLabel(
        alignment: .left,
        fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular),
        fontСolor: AppColor.textInvert
    )
    private let contentLabel = AppLabel(
        alignment: .left,
        fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
        numberLines: 0
    )
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Layout.itemSpacing
        layout.itemSize = CGSize(width: Layout.itemWidth, height: Layout.itemHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Construction
    
    init(news: NewsModel) {
        dataSource = NewsDetailCollectionViewDataSource(images: news.images)
        super.init(frame: .zero)
        configure(news: news)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = coverImageView.bounds
    }

    // MARK: - Private functions
    
    private func configure(news: NewsModel) {
        collectionView.dataSource = dataSource
        collectionView.registerCell(NewsDetailCollectionViewCell.self)
        titleLabel.text = news.title
        dateLabel.text = news.date
        contentLabel.text = news.subtitle
        coverImageView.downloadedImage(from: news.imageUrls[.original] ?? "")
        configureUI()
    }
    
    private func configureUI() {
        addSubviews([coverImageView, titleLabel, dateLabel, contentLabel, collectionView])
        [coverImageView, titleLabel, dateLabel, contentLabel, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        titleLabel.numberOfLines = maximumTitleLines
        configureCoverImageView()
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: coverHeight),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideInset),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideInset),
            dateLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -sideInset),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideInset),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -topInset),
            
            contentLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: sideInset),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideInset),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideInset),
            
            collectionView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: sideInset),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Layout.itemHeight)
        ])
    }
    
    private func configureCoverImageView() {
        configureGradientLayer()
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.masksToBounds = true
    }
    
    private func configureGradientLayer() {
        coverImageView.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [AppColor.coverGradient1.cgColor, AppColor.coverGradient2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
    }
}
