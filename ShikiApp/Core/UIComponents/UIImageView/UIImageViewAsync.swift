//
//  UIImageViewAsync.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 02.02.2023.
//
// Пример использования:
// myImageView.downloadedImage(from: "http:\.........")

import AVFoundation
import UIKit

final class UIImageViewAsync: UIImageView {

    // MARK: - Private properties
    
    private let iconHeight: CGFloat = 52.0
    private let playIconImageView = UIImageView(image: AppImage.OtherIcons.play)
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [AppColor.coverGradient1.cgColor, AppColor.coverGradient2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()
    
    private var task: URLSessionDataTask?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicatorStyle = UIActivityIndicatorView.Style.medium
        let activityIndicator = UIActivityIndicatorView.init(style: indicatorStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var completion: (() -> Void)?

    // MARK: - Construction
    
    init() {
        super.init(frame: .zero)
        setActivityIndicator()
        layer.addSublayer(gradientLayer)
        setPlayIcon()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Functions
    
    /// Загрузка картинок по URL
    /// - Parameters:
    ///   - link: URL  изображения
    ///   - mode: ContentMode  по умолчанию  scaleAspectFit
    ///   - isActivityIndicator: наличие ActivityIndicator по умолчанию true
    func downloadedImage(from link: String,
                         contentMode mode: ContentMode = .scaleAspectFit,
                         isActivityIndicator: Bool = true,
                         hasGradientLayer: Bool = false,
                         isVideoPreview: Bool = false) {
        
        guard let url = URL(string: link) else { return }
        
        downloadedImage(
            from: url,
            contentMode: mode,
            isActivityIndicator: isActivityIndicator,
            hasGradientLayer: hasGradientLayer,
            isVideoPreview: isVideoPreview
        )
    }
    
    func downloadedImage(from url: URL,
                         contentMode mode: ContentMode = .scaleAspectFit,
                         isActivityIndicator: Bool = true,
                         hasGradientLayer: Bool = false,
                         isVideoPreview: Bool = false) {
        contentMode = mode
        gradientLayer.isHidden = !hasGradientLayer
        playIconImageView.isHidden = !isVideoPreview
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(
            memoryCapacity: Constants.ImageCacheParam.memoryCapacity,
            diskCapacity: Constants.ImageCacheParam.diskCapacity,
            diskPath: "images"
        )
        configuration.httpMaximumConnectionsPerHost = Constants.ImageCacheParam.maximumConnections
        
        let session = URLSession(configuration: configuration)
        
        if isActivityIndicator {
            activityIndicator.startAnimating()
        }
        
        if let task = task {
            task.cancel()
        }
        
        self.task = session.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                self.image = image
                self.activityIndicator.removeFromSuperview()
                self.completion?()
            }
        }
        task?.resume()
    }
    
    func configureCompletion(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    func taskCancel() {
        task?.cancel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: - Private functions
    
    private func setActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setPlayIcon() {
        addSubview(playIconImageView)
        playIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playIconImageView.heightAnchor.constraint(equalToConstant: iconHeight),
            playIconImageView.widthAnchor.constraint(equalToConstant: iconHeight)
        ])
    }
}
