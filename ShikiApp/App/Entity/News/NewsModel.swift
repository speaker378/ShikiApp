//
//  NewsModel.swift
//  ShikiApp
//
//  Created by Сергей Черных on 23.01.2023.
//

import UIKit

struct NewsModel {
    let image: UIImage?
    let date: String?
    let title: String?
    let subtitle: String?
    let images: [UIImage?]
    let URLString: String?
}

final class NewsModelFactory {
    func makeModels(from news: TopicsResponseDTO) -> [NewsModel] {
        return news.compactMap(self.convertModel)
    }
    
    private func convertModel(from news: TopicDTO) -> NewsModel {
        let image = AppImage.ErrorsIcons.nonConnectionIcon
        let date = news
            .createdAt?
            .convertToDate()?
            .convertToString(with: Constants.DateFormatter.dayMonthCommaHoursMinutes, relative: true) ?? ""
        let title = news.topicTitle
        let subtitle = news.htmlBody?.htmlToString()
        let images = [AppImage.ErrorsIcons.nonConnectionIcon, AppImage.ErrorsIcons.nonConnectionIcon]
        let URLString = "\(Constants.Url.baseUrl)\(news.linked?.url ?? "")"
        
        return NewsModel(
            image: image,
            date: date,
            title: title,
            subtitle: subtitle,
            images: images,
            URLString: URLString
        )
    }
}
