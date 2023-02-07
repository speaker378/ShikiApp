//
//  AppCollectionViewCell.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import AVFoundation
import UIKit

final class AppCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties
    
    private let imageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.CornerRadius.small
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Construction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(content: String) {
        if content.contains("youtube") {
            imageView.downloadedImage(
                from: content,
                contentMode: .scaleAspectFill,
                hasGradientLayer: true,
                isVideoPreview: true
            )
        } else {
            imageView.downloadedImage(from: content, contentMode: .scaleAspectFill)
        }
    }

    // MARK: - Private functions
    
    private func configureUI() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
