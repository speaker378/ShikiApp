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
    // ...
}

final class NewsModelFactory {
    func makeModels(from news: [NewsModelAPI]) -> [NewsModel] {
        return news.compactMap(self.viewModel)
    }
    
    private func viewModel(from news: NewsModelAPI) -> NewsModel {
        let image = news.image
        let date = news.date
        let title = news.title
        let subtitle = news.subtitle

        return NewsModel(
            image: image,
            date: date,
            title: title,
            subtitle: subtitle
        )
    }
}
