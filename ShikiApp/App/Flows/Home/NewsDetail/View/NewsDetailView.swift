//
//  NewsDetailView.swift
//  ShikiApp
//
//  Created by Alla Shkolnik on 22.01.2023.
//

import UIKit

final class NewsDetailView: UIView {
    
    // MARK: - private properties
    
    private let coverImageView = UIImageView()
    private let titleLabel: AppLabel
    private let metaDataLabel: AppLabel
    private let contentLabel: AppLabel
    
    // MARK: - init
    
    init(coverImage: UIImage, title: String, meta: String, content: String) {
        self.coverImageView.image = coverImage
        self.titleLabel = AppLabel(
            title: title,
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 20, weight: .bold),
            fontСolor: AppColor.textInvert,
            numberLines: 0
        )
        self.metaDataLabel = AppLabel(
            title: meta,
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular),
            fontСolor: AppColor.textInvert
        )
        self.contentLabel = AppLabel(title: content, alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular), numberLines: 0)
        super.init(frame: .zero)
        backgroundColor = .blue
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = CAGradientLayer()
        let gradient1CGColor = CGColor(gray: 1.0, alpha: 0)
        let gradient2CGColor = CGColor(gray: 0.1, alpha: 0.7)
        gradientLayer.colors = [gradient1CGColor, gradient2CGColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = coverImageView.bounds
        coverImageView.layer.addSublayer(gradientLayer)
    }
    
    private func configureUI() {
        addSubviews([coverImageView, titleLabel, metaDataLabel, contentLabel])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        metaDataLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = .systemGray6 // убрать это, просто для отладки
        coverImageView.layer.masksToBounds = true
        
        // разобрать по функциям
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 200.0),
            
            metaDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Inset.inset16),
            metaDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Inset.inset16),
            metaDataLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -Constants.Inset.inset16),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Inset.inset16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Inset.inset16),
            titleLabel.bottomAnchor.constraint(equalTo: metaDataLabel.topAnchor, constant: -Constants.Inset.inset4),
            
            contentLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: Constants.Inset.inset16),
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Inset.inset16),
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Inset.inset16),
            contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.Inset.inset24)
        ])
    }
    
}
