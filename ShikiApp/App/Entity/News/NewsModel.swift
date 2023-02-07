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
    let footerImageURLs: [String]
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
        let footer = news.htmlFooter
        var imageURLs = footer?.imageURLs ?? []
        imageURLs.append(contentsOf: footer?.youtubePreviewURLs ?? [])
        let URLString = "\(Constants.Url.baseUrl)\(news.linked?.url ?? "")"
        
        return NewsModel(
            imageUrls: imageUrls,
            date: date,
            title: title,
            subtitle: subtitle,
            images: images,
            footerImageURLs: imageURLs,
            URLString: URLString
        )
    }
    
    private func extractImageAddresses(from footer: String?) -> [ImageSize: String] {
        var result = [ImageSize: String]()
        guard let footer else { return result }
        let imageUrls = footer
            .extractURLs()
            .filter { $0.contains(".jpg") }
        if (imageUrls.first(where: { $0.contains("youtube") }) != nil) {
            let imgUrl = imageUrls.first(where: { $0.contains("youtube") })
            result[.preview] = imgUrl
            result[.original] = imgUrl
            return result
        }
        result[.preview] = imageUrls.first(where: { $0.contains("preview") })
        result[.original] = imageUrls.first(where: { $0.contains("original") })
        return result
    }
}
