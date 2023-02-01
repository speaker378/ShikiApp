//
//  UIImageViewAsync.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 02.02.2023.
//
// Пример использования:
// myImageView.downloadedImage(from: "http:\.........")

import UIKit

final class UIImageViewAsync: UIImageView {

    // MARK: - Private properties
    
    private var task: URLSessionDataTask?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicatorStyle = UIActivityIndicatorView.Style.medium
        let activityIndicator = UIActivityIndicatorView.init(style: indicatorStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: - Construction
    
    init() {
        super.init(frame: .zero)
        setActivityIndicator()
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
    ///   - isActivityIndicator: наличие ActivityIndicator по умалчанию true
    func downloadedImage(from link: String,
                         contentMode mode: ContentMode = .scaleAspectFit,
                         isActivityIndicator: Bool = true) {
        guard let url = URL(string: link) else { return }
        
        downloadedImage(from: url, contentMode: mode, isActivityIndicator: isActivityIndicator)
    }
    
    func downloadedImage(from url: URL,
                         contentMode mode: ContentMode = .scaleAspectFit,
                         isActivityIndicator: Bool = true) {
        contentMode = mode
        
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
            }
        }
        task?.resume()
    }
    
    func taskCancel() {
        task?.cancel()
    }

    // MARK: - Private functions
    
    private func setActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.center = self.center
    }

}
