//
//  NewsDetailImageContentView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 09.02.2023.
//

import UIKit

final class NewsDetailImageContentView: UIView {
    
    private let view = UIView()
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
    private var imageURLString: String
    private var imageSize: CGSize?

    // MARK: - Construction
    
    init(URLString: String) {
        self.imageURLString = URLString
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
        addSubview(view)
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        [view, imageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    private func scalingImage() {
        imageView.configureCompletion { [weak self] in
            guard let self = self, let imageSize = self.imageView.image?.size else {
                return
            }
            let newSize = self.countScalingSize(originSize: imageSize, targetSize: self.scrollView.frame.size)

            NSLayoutConstraint.activate([
                self.imageView.widthAnchor.constraint(equalToConstant: newSize.width),
                self.imageView.heightAnchor.constraint(equalToConstant: newSize.height)
            ])
        }
    }
    
    // TODO: - вынести в презентер?
    private func countScalingSize(originSize: CGSize, targetSize: CGSize) -> CGSize {
        let widthRatio = targetSize.width / originSize.width
        let heightRatio = targetSize.height / originSize.height
        
        let newSize = widthRatio > heightRatio
        ? CGSize(width: originSize.width * heightRatio, height: originSize.height * heightRatio)
        : CGSize(width: originSize.width * widthRatio, height: originSize.height * widthRatio)
        return newSize
    }
}

// MARK: - UIScrollViewDelegate

extension NewsDetailImageContentView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
