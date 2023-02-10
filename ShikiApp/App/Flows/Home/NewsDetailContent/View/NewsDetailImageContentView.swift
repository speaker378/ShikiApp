//
//  NewsDetailImageContentView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 09.02.2023.
//

import UIKit

final class NewsDetailImageContentView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.contentMode = .center
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let imageView = UIImageViewAsync()

    // MARK: - Construction
    
    init(URLString: String) {
        super.init(frame: .zero)
        imageView.downloadedImage(from: URLString, contentMode: .scaleAspectFit)
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scalingImage()
    }

    // MARK: - Private functions
    
    private func configure() {
        scrollView.delegate = self
        configureUI()
    }
    
    private func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func scalingImage() {
        imageView.configureCompletion { [weak self] in
            guard let self = self, let imageSize = self.imageView.image?.size else {
                return
            }
            let newSize = imageSize.scaleToSize(self.scrollView.frame.size)

            NSLayoutConstraint.activate([
                self.imageView.widthAnchor.constraint(equalToConstant: newSize.width),
                self.imageView.heightAnchor.constraint(equalToConstant: newSize.height)
            ])
        }
    }
}

// MARK: - UIScrollViewDelegate

extension NewsDetailImageContentView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
