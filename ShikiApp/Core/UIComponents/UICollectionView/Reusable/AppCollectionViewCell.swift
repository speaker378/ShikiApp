//
//  AppCollectionViewCell.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import UIKit

final class AppCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties
    
    private let leftInset = 8.0
    private let bottomInset = 8.0
    private let rightInset = 8.0
    private let commentHeight = 16.0
    private let imageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.CornerRadius.small
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let commentLabel: AppLabel = {
        let label = AppLabel(
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular),
            fontСolor: AppColor.textInvert,
            numberLines: 1
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [AppColor.coverGradient1.cgColor, AppColor.coverGradient2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()

    // MARK: - Construction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(content: String, comment: String? = nil) {
        if content.contains("youtube") {
            imageView.downloadedImage(from: content, contentMode: .scaleAspectFill)
            imageView.layer.addSublayer(gradientLayer)
            addPlayVideoIcon()
        } else {
            imageView.downloadedImage(from: content, contentMode: .scaleAspectFill)
        }
        if let comment {
            commentLabel.text = comment
            commentLabel.isHidden = false
        } else {
            commentLabel.isHidden = true
        }
    }

    // MARK: - Private functions
    
    private func configureUI() {
        addSubviews(imageView, commentLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            commentLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width - leftInset - rightInset),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomInset),
            commentLabel.heightAnchor.constraint(equalToConstant: commentHeight)
        ])
    }
    
    private func addPlayVideoIcon() {
        let iconHeight: CGFloat = 52.0
        let playIconImageView = UIImageView(image: AppImage.OtherIcons.play)
        
        playIconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playIconImageView)

        NSLayoutConstraint.activate([
            playIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playIconImageView.heightAnchor.constraint(equalToConstant: iconHeight),
            playIconImageView.widthAnchor.constraint(equalToConstant: iconHeight)
        ])
    }
}
