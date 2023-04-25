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
        static let redirectUri = "ShikiApp://callback"
    }

    enum Insets {
        /// отступ по краям экрана, можно использовать и сверху, снизу
        static let sideInset: CGFloat = 16.0
        /// высота у кнопок, полей
        static let controlHeight: CGFloat = 48.0
        static let controlHeightLarge: CGFloat = 55.0
        // высота и ширина обложки у ячеек
        static let coverHeight: CGFloat = 112.0
        /// ширина обложки у ячеек
        static let coverWidth: CGFloat = 88.0
        static let iconSmallHeight: CGFloat = 24.0
        static let iconMediumHeight: CGFloat = 32.0
    }

    enum Spacing {
        static let large: CGFloat = 24.0
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
        static let year = "yyyy"
        static let yearMonthDay = "yyyy-MM-dd"
    }

    enum Prefix {
        static let byte = 1
        static let kilobyte = 1024
        static let megabyte = 1_048_576
    }

    enum ImageCacheParam {
        static let memoryCapacity = 50 * Prefix.megabyte
        static let diskCapacity = 50 * Prefix.megabyte
        static let maximumConnections = 5
    }

    enum Dates {
        static let startYearForFilter = 1917
    }
    
    enum Timeouts {
        static let networkRequest = 15.0
    }
    enum FilterParameters {
        static let delimiter: Character = ","
    }
    
    enum CensoredParameters {
        static let uncensoredAge = 18
    }
    
    enum SearchHeader {
        static let emptyStringResult = "Лучшие"
        static let exactResult = "Найдено:"
        static let approximateResult = "Результаты поиска"
    }
    
    enum LimitsForRequest {
        static let itemsLimit: Int = 5000
        static let limitRequestsPerSecond: Int = 5
    }

    static let kindsDictionary = [
        "all": "Все",
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

    static let animeStatusDictionary = [
        "all": "Все",
        "anons": "Анонсировано",
        "ongoing": "Сейчас выходит",
        "released": "Вышедшее",
        "latest": "Недавно вышедшее"
    ]

    static let mangaStatusDictionary = [
        "all": "Все",
        "anons": "Анонсировано",
        "ongoing": "Сейчас издается",
        "released": "Издано",
        "latest": "Недавно издано",
        "paused": "Приостановлено",
        "discontinued": "Прекращено"
    ]

    static let singleDateKinds = ["movie", "music", "one_shot"]
    
    static let scoreColors: [String: UIColor] = [
        "10": AppColor.green,
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
    
    static let watchingStatuses = [
        "completed": Texts.ListTypesSelectItems.completed,
        "planned": Texts.ListTypesSelectItems.planned,
        "watching": Texts.ListTypesSelectItems.watching,
        "on_hold": Texts.ListTypesSelectItems.onHold,
        "dropped": Texts.ListTypesSelectItems.dropped,
        "rewatching": Texts.ListTypesSelectItems.rewatching
    ]
    
    static let watchingImageStatuses = [
        "completed": AppImage.UserListIcons.watched,
        "planned": AppImage.UserListIcons.watching,
        "watching": AppImage.UserListIcons.watching,
        "on_hold": AppImage.UserListIcons.watching,
        "dropped": AppImage.UserListIcons.dropped,
        "rewatching": AppImage.UserListIcons.rewatching
        ]
        
    static let mangaStatuses = [
        "ongoing": "Выходит",
        "released": "Издано",
        "paused": "Приостановлено",
        "discontinued": "Прекращено",
        "anons": "Анонсировано"
    ]
    
    static let animeStatuses = [
        "ongoing": "Онгоинг",
        "released": "Вышло",
        "anons": "Анонсировано"
    ]
    
    static let rating = [
        "r": "R",
        "pg": "PG",
        "pg_13": "PG-13",
        "r_plus": "R+",
        "rx": "RX",
        "none": ""
    ]
    
    enum NotificationKeys: String {
        case authState
    }
    
    static let censoredGenres = ["hentai", "yaoi", "yuri"]
    
    enum MangaUserRateKind: String {
        case manga = "Манга"
        case manhwa = "Манхва"
        case manhua = "Маньхуа"
        case lightNovel = "Ранобэ"
        case novel = "Новелла"
        case oneShot = "Ваншот"
        case doujin = "Додзинси"
    }
}
