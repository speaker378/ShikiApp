//
//  SearchConstants.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 04.02.2023.
//

import UIKit

struct SearchConstants {
    static let keyboardDelay = 1000
    static let kindsDictionary = ["tv": "TV Сериал", "tv_13": "TV Сериал(короткий)",
                                  "tv_24": "TV Сериал(средний)", "tv_48": "TV Сериал(длинный)",
                                  "movie": "Фильм", "music": "Клип", "special": "Спешл",
                                  "ova": "OVA", "ona": "ONA", "manga": "Манга",
                                  "manhwa": "Манхва", "manhua": "Маньхуа",
                                  "light_novel": "Ранобэ", "novel": "Новелла",
                                  "one_shot": "Ваншот", "doujin": "Додзинси"]
    static let singleDateKinds = ["movie", "music", "one_shot"]
    static let scoreColors: [Character: UIColor] = [
        "9": AppColor.green,
        "8": AppColor.green,
        "7": AppColor.green,
        "6": AppColor.yellow,
        "5": AppColor.red,
        "4": AppColor.red,
        "3": AppColor.red,
        "2": AppColor.red,
        "1": AppColor.red
    ]
}
