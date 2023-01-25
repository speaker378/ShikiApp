//
//  NewsDetailView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import UIKit

final class NewsDetailView: UIView {
    
    // MARK: - Private properties
    
    private struct NewsConstants {
        static let itemWidht: CGFloat = 260
        static let itemHeight: CGFloat = 160
        static let coverHeight: CGFloat = 200
        static let maximumTitleLines = 5
    }
    
    private let coverImageView = UIImageView()
    private let titleLabel: AppLabel
    private let metaDataLabel: AppLabel
    private let contentLabel: AppLabel
    private let gradientLayer = CAGradientLayer()
    private let datasource: UICollectionViewDataSource?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.Spacing.spacing8
        layout.itemSize = CGSize(width: NewsConstants.itemWidht, height: NewsConstants.itemHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Init
    
    init(news: NewsModel) {
        coverImageView.image = news.image ?? AppImage.ErrorsIcons.nonConnectionIcon
        titleLabel = AppLabel(
            title: news.title ?? "",
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 20, weight: .bold),
            fontСolor: AppColor.textInvert,
            numberLines: NewsConstants.maximumTitleLines
        )
        metaDataLabel = AppLabel(
            title: news.date ?? "",
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular),
            fontСolor: AppColor.textInvert
        )
        contentLabel = AppLabel(
            title: news.subtitle ?? "",
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
            numberLines: 0
        )
        datasource = NewsDetailCollectionViewDataSource(images: news.images)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = coverImageView.bounds
    }
    
    // MARK: - Private methods
    
    private func configure() {
        collectionView.dataSource = datasource
        collectionView.registerCell(NewsDetailCollectionViewCell.self)
        addSubviews([coverImageView, titleLabel, metaDataLabel, contentLabel, collectionView])
        configureConstraints()
    }
    
    private func configureConstraints() {
        configureCoverImageView()
        configureMetaDataLabel()
        configureTitleLabel()
        configureContentLabel()
        configureCollectionView()
    }
    
    private func configureGradientLayer() {
        coverImageView.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [AppColor.coverGradient1.cgColor, AppColor.coverGradient2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
    }
    
    private func configureCoverImageView() {
        configureGradientLayer()
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.masksToBounds = true
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: NewsConstants.coverHeight)
        ])
    }
    
    private func configureMetaDataLabel() {
        metaDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            metaDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Inset.inset16),
            metaDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Inset.inset16),
            metaDataLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -Constants.Inset.inset16)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Inset.inset16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Inset.inset16),
            titleLabel.bottomAnchor.constraint(equalTo: metaDataLabel.topAnchor, constant: -Constants.Inset.inset4)
        ])
    }
    
    private func configureContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: Constants.Inset.inset16),
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Inset.inset16),
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Inset.inset16)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: Constants.Inset.inset16),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: NewsConstants.itemHeight)
        ])
    }
    
}
