//
//  NewsDetailCollectionViewCell.swift
//  ShikiApp
//
//  Created by Alla Shkolnik on 22.01.2023.
//

import UIKit

class NewsDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - private properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.Inset.inset8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(image: UIImage) {
//        addSubview(imageView)
        configureUI()
//        imageView.image = image
    }
    
    private func configureUI() {
        let vieww = UIView()
        vieww.backgroundColor = .orange
        vieww.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vieww)
        NSLayoutConstraint.activate([
            vieww.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vieww.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            vieww.heightAnchor.constraint(equalToConstant: 100.0),
            vieww.widthAnchor.constraint(equalToConstant: 100.0)
            ])
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: 120.0)
//        ])
    }
    
}
