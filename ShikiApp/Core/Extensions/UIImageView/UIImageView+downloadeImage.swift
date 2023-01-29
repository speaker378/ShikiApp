//
//  UIImageView+downloadeImage.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 29.01.2023.
//
// Пример использования:
// myImageView.downloadedImage(from: "http:\.........")

import UIKit

extension UIImageView {
    
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
        
        let indicatorStyle = UIActivityIndicatorView.Style.medium
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: indicatorStyle)
        addSubview(activityIndicator)
        activityIndicator.center = self.center
        
        if isActivityIndicator {
            activityIndicator.startAnimating()
        }
        
        session.dataTask(with: url) { data, response, error in
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
                activityIndicator.removeFromSuperview()
            }
        }.resume()
    }
}
