//
//  NewsModel.swift
//  ShikiApp
//
//  Created by Сергей Черных on 23.01.2023.
//

import UIKit

struct NewsModel {
    
    let imageUrls: [ImageSize: String]
    let date: String?
    let title: String?
    let subtitle: String?
    let images: [UIImage?]
    let URLString: String?
}

enum ImageSize {
    case original, preview, x96, x48
}

final class NewsModelFactory {
    
    func makeModels(from news: TopicsResponseDTO) -> [NewsModel] {
        return news.compactMap(self.convertModel)
    }
    
    private func convertModel(from news: TopicDTO) -> NewsModel {
        let imageUrls = getImageSizes(for: news.linked?.image)
        let date = news
            .createdAt?
            .convertToDate()?
            .convertToString(with: Constants.DateFormatter.dayMonthCommaHoursMinutes, relative: true) ?? ""
        let title = news.topicTitle
        let subtitle = news.htmlBody?.htmlToString()
        let images = [AppImage.ErrorsIcons.nonConnectionIcon, AppImage.ErrorsIcons.nonConnectionIcon]
        let URLString = "\(Constants.Url.baseUrl)\(news.linked?.url ?? "")"
        
        return NewsModel(
            imageUrls: imageUrls,
            date: date,
            title: title,
            subtitle: subtitle,
            images: images,
            URLString: URLString
        )
    }
    
    private func getImageSizes(for image: ImageDTO?) -> [ImageSize: String] {
        guard let image else { return [:] }
        return [
            .original: "\(Constants.Url.baseUrl)\(image.original)",
            .preview: "\(Constants.Url.baseUrl)\(image.preview)",
            .x96: "\(Constants.Url.baseUrl)\(image.x96)",
            .x48: "\(Constants.Url.baseUrl)\(image.x48)"
        ]
    }
}
