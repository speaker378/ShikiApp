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
    case original, preview
}

final class NewsModelFactory {
    
    func makeModels(from news: TopicsResponseDTO) -> [NewsModel] {
        return news.compactMap(self.convertModel)
    }
    
    private func convertModel(from news: TopicDTO) -> NewsModel {
        let imageUrls = extractImageAddresses(from: news.htmlFooter)
        let date = news
            .createdAt?
            .convertToDate()?
            .convertToString(with: Constants.DateFormatter.dayMonthCommaHoursMinutes, relative: true) ?? ""
        let title = news.topicTitle
        let subtitle = news.htmlBody?.htmlToString()
        let images = [AppImage.ErrorsIcons.nonConnectionIcon, AppImage.ErrorsIcons.nonConnectionIcon]
        let URLString = "\(Constants.Url.baseUrl)/forum/news/\(news.id)"
        
        return NewsModel(
            imageUrls: imageUrls,
            date: date,
            title: title,
            subtitle: subtitle,
            images: images,
            URLString: URLString
        )
    }
    
    private func extractImageAddresses(from footer: String?) -> [ImageSize: String] {
        var result = [ImageSize: String]()
        guard let footer else { return result }
        let urls = footer.extractURLs()
        let imageUrls = urls.filter { $0.contains(".jpg") }
        result[.preview] = imageUrls.first(where: { $0.contains("preview") })
        result[.original] = imageUrls.first(where: { $0.contains("original") })
        return result
    }
}
