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
    let images: [UIImage]
    let URLString: String?
}

// TODO: для проверки
var NEWSCELLMODELLIST: [NewsModelAPI] {
    return (0..<20).map { _ in
        NewsModelAPI(
            image: (UIImage(named: "noConnectionIcon")),
            date: "Cегодня, 12:00",
            title: "Анонсировано аниме «Kekkon Yubiwa Monogatari»",
            subtitle: """
Сато влюблен в свою подругу детства и соседку Химэ [ヒメ] с тех пор, как она и ее \
дедушка появились из ниоткуда десять лет назад. Теперь, когда Химэ является первой \
красавицей и умницей школы, Сато стало еще сложнее признаться в своих чувствах. \
Однако в годовщину их встречи он набирается храбрости и все-таки признается. Получится \
ли у нашего героя превратить их дружбу во что-то большее? Или совсем другая судьба ждет \
эту тесно связанную между собой пару?
""",
            images: [AppImage.ErrorsIcons.nonConnectionIcon, AppImage.ErrorsIcons.nonConnectionIcon, AppImage.ErrorsIcons.nonConnectionIcon],
            URLString: "https://shikimori.one/%D0%92%D0%B5%D0%BB1%D1%87%D0%B0%D0%B9%D1%88%D0%B8%D0%B9"
        )
    }
    
}
