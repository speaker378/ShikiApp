//
//  NewsDetailView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import UIKit

final class NewsDetailView: UIView {

    // MARK: - Private properties
    
    private let coverHeight: CGFloat = 200
    private let topInset: CGFloat = 4.0
    private let maximumTitleLines = 5
    private let coverImageView = UIImageViewAsync()
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
    private let collectionView: AppCollectionView
    private var tapHandler: ((String) -> Void)?

    // MARK: - Construction
    
    init(news: NewsModel) {
        collectionView = AppCollectionView(imageURLStrings: news.footerImageURLs)
        super.init(frame: .zero)
        configure(news: news)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func tapHandler(completion: @escaping (String) -> Void) {
        tapHandler = completion
    }

    // MARK: - Private functions
    
    private func configure(news: NewsModel) {
        titleLabel.text = news.title
        dateLabel.text = news.date
        contentLabel.text = news.subtitle
        coverImageView.downloadedImage(from: news.imageUrls[.original] ?? "", hasGradientLayer: true)
        collectionView.configureTapHandler { [weak self] content in
            self?.tapHandler?(content)
        }
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
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            dateLabel.bottomAnchor.constraint(
                equalTo: coverImageView.bottomAnchor,
                constant: -Constants.Insets.sideInset
            ),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -topInset),
            
            contentLabel.topAnchor.constraint(
                equalTo: coverImageView.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            
            collectionView.topAnchor.constraint(
                equalTo: contentLabel.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureCoverImageView() {
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.masksToBounds = true
    }
}
