//
//  NewsDetailCollectionViewCell.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 22.01.2023.
//

import UIKit

final class NewsDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
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
        imageView.image = nil
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
    // MARK: - Private functions
    
    private func configureUI() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
