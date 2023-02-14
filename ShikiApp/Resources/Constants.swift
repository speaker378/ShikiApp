//
//  Constants.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
//  класс предназначен для различных констант, используемых по всему приложению

import UIKit

struct Constants {
    
    enum Url {
        static let apiUrl = Bundle.main.object(forInfoDictionaryKey: HttpConstants.apiUrl) as? String ?? ""
        static let baseUrl = Bundle.main.object(forInfoDictionaryKey: HttpConstants.baseUrl) as? String ?? ""
        static let baseYoutubeUrl = "https://www.youtube.com/embed/"
        static let deeplinkYoutubeUrl = "https://www.youtube.com/watch?v="
    }
    
    enum Keys {
        
    }
    
    enum Insets {
        /// отступ по краям экрана, можно использовать и сверху, снизу
        static let sideInset: CGFloat = 16.0
        /// высота у кнопок, полей
        static let controlHeight: CGFloat = 48.0
        /// высота обложки у ячеек
        static let coverHeight: CGFloat = 112.0
        /// ширина обложки у ячеек
        static let coverWidth: CGFloat = 88.0
        static let iconSmallHeight: CGFloat = 24.0
        static let iconMediumHeight: CGFloat = 32.0
    }
    
    enum Spacing {
        static let medium: CGFloat = 8.0
        static let small: CGFloat = 4.0
    }
    
    enum CornerRadius {
        static let medium: CGFloat = 16.0
        static let small: CGFloat = 8.0
        static let xSmall: CGFloat = 4.0
    }

    enum DateFormatter {
        static let dayMonthCommaHoursMinutes = "dd MMMM, HH:mm"
        static let yearMonthDay = "yyyy-MM-dd"
    }
    
    enum Prefix {
        static let byte = 1
        static let kilobyte = 1024
        static let megabyte = 1048576
    }
    
    enum ImageCacheParam {
        static let memoryCapacity = 50 * Prefix.megabyte
        static let diskCapacity = 50 * Prefix.megabyte
        static let maximumConnections = 5
    }
    
    enum SearchHeader {
        static let emptyStringResult = "Лучшие"
        static let exactResult = "Найдено:"
        static let approximateResult = "Результаты поиска"
    }
    
    static let kindsDictionary = [
        "tv": "TV Сериал",
        "tv_13": "TV Сериал(короткий)",
        "tv_24": "TV Сериал(средний)",
        "tv_48": "TV Сериал(длинный)",
        "movie": "Фильм",
        "music": "Клип",
        "special": "Спешл",
        "ova": "OVA",
        "ona": "ONA",
        "manga": "Манга",
        "manhwa": "Манхва",
        "manhua": "Маньхуа",
        "light_novel": "Ранобэ",
        "novel": "Новелла",
        "one_shot": "Ваншот",
        "doujin": "Додзинси"
    ]
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
