//
//  NewsDetailView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import UIKit

final class NewsDetailView: UIView {
    
    // MARK: - Private properties
    
    private struct Constants {
        static let itemWidht: CGFloat = 260
        static let itemHeight: CGFloat = 160
        static let coverHeight: CGFloat = 200
        static let sideInset: CGFloat = 16.0
        static let maximumTitleLines = 5
    }
    
    private let coverImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let dataSource: UICollectionViewDataSource?
    private let titleLabel = AppLabel(
        alignment: .left,
        fontSize: AppFont.openSansFont(ofSize: 20, weight: .bold),
        fontСolor: AppColor.textInvert,
        numberLines: Constants.maximumTitleLines
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
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8.0
        layout.itemSize = CGSize(width: Constants.itemWidht, height: Constants.itemHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Construction
    
    init(news: NewsModel) {
        coverImageView.image = news.image ?? AppImage.ErrorsIcons.nonConnectionIcon
        dataSource = NewsDetailCollectionViewDataSource(images: news.images)
        super.init(frame: .zero)
        configure(title: news.title ?? "", date: news.date ?? "", content: news.subtitle ?? "")
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = coverImageView.bounds
    }
    
    // MARK: - Private functions
    
    private func configure(title: String, date: String, content: String) {
        collectionView.dataSource = dataSource
        collectionView.registerCell(NewsDetailCollectionViewCell.self)
        titleLabel.text = title
        dateLabel.text = date
        contentLabel.text = content
        configureUI()
    }
    
    private func configureUI() {
        addSubviews([coverImageView, titleLabel, dateLabel, contentLabel, collectionView])
        [coverImageView, titleLabel, dateLabel, contentLabel, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureCoverImageView()
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: Constants.coverHeight),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideInset),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideInset),
            dateLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -Constants.sideInset),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideInset),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4.0),
            
            contentLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: Constants.sideInset),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideInset),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideInset),
            
            collectionView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: Constants.sideInset),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.itemHeight)
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
