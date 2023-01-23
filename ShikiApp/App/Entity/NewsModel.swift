//
//  NewsModel.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

struct NewsModel {
    let image: UIImage?
    let date: String?
    let title: String?
    let subtitle: String?
    // ...
}

struct NewsViewModel {
    let image: UIImage?
    let date: String?
    let title: String?
    let subtitle: String?
    // ...
}

final class NewsViewModelFactory {
    func constructViewModels(from news: [NewsModel]) -> [NewsViewModel] {
        return news.compactMap(self.viewModel)
    }
    
    private func viewModel(from news: NewsModel) -> NewsViewModel {
        let image = news.image
        let date = news.date
        let title = news.title
        let subtitle = news.subtitle

        return NewsViewModel(
            image: image,
            date: date,
            title: title,
            subtitle: subtitle
        )
    }
}

// TODO: для проверки
var NEWSCELLMODELLIST: [NewsModel] {
        return (0..<20).map { _ in
            NewsModel(
                image: (UIImage(named: "noConnectionIcon")),
                date: "Cегодня, 12:00",
                title: "Анонсировано аниме «Dog Signal»",
                subtitle: "Манга «Сигнал собаки» от получит аниме-адаптацию. Трансляция начнется осенью этого года."
            )
        }
}
