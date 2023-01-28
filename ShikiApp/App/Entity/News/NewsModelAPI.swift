//
//  NewsModelAPI.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

struct NewsModelAPI {
    let image: UIImage?
    let date: String?
    let title: String?
    let subtitle: String?
    // ...
}

// TODO: для проверки
var NEWSCELLMODELLIST: [NewsModelAPI] {
    var result = (0..<4).map { _ in
        NewsModelAPI(
            image: (UIImage(named: "noConnectionIcon")),
            date: "Cегодня, 12:00",
            title: "Анонсировано аниме «Dog Signal»",
            subtitle: "Манга «Сигнал собаки» от получит аниме-адаптацию. Трансляция начнется осенью этого года."
        )
    }
    
    result.append(
        NewsModelAPI(
            image: (UIImage(named: "noConnectionIcon")),
            date: "Cегодня, 12:00",
            title: "Анонсировано аниме",
            subtitle: "Манга «Сигнал собаки» от получит аниме-адаптацию. Трансляция начнется осенью этого года."
        )
    )
    
    result.append(
        NewsModelAPI(
            image: (UIImage(named: "noConnectionIcon")),
            date: "Cегодня, 12:00",
            title: "Манга «Сигнал собаки» от получит аниме-адаптацию. Трансляция начнется осенью этого года.",
            subtitle: "Манга «Сигнал собаки» от получит аниме-адаптацию. Трансляция начнется осенью этого года."
        )
    )
    return result
}
