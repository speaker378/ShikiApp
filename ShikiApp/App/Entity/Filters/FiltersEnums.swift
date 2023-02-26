//
//  FiltersEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.02.2023.
//

import Foundation

// MARK: - FilterDescriptableProtocol

protocol FilterDescriptableProtocol: CaseIterable {
    static var descriptions: [String] { get }
}

// MARK: - FilterValueProvidedProtocol

protocol FilterValueProvidedProtocol: CaseIterable {
    associatedtype ValueType
    var value: ValueType? { get }
}

// MARK: - FilterProtocol

protocol FilterProtocol: FilterValueProvidedProtocol, FilterDescriptableProtocol {}

// MARK: - AnimeFilterKinds

enum AnimeFilterKinds: String, FilterDescriptableProtocol {
    case all
    case tvSeries = "tv"
    case movie
    case ova
    case ona
    case special
    case music
    case tv13 = "tv_13"
    case tv24 = "tv_24"
    case tv48 = "tv_48"

    // MARK: - Properties

    static var descriptions: [String] {
        Self.allCases.map { Constants.kindsDictionary[$0.rawValue] ?? "" }
    }
}

// MARK: - MangaFilterKinds

enum MangaFilterKinds: String, FilterDescriptableProtocol {
    case all
    case manga
    case manhwa
    case manhua
    case novel
    case doujin
    case lightNovel = "light_novel"
    case oneShot = "one_shot"

    // MARK: - Properties

    static var descriptions: [String] {
        Self.allCases.map { Constants.kindsDictionary[$0.rawValue] ?? "" }
    }
}

// MARK: - RanobeFilterKinds

enum RanobeFilterKinds: String, FilterDescriptableProtocol {
    case all
    case lightNovel = "light_novel"
    case novel

    // MARK: - Properties

    static var descriptions: [String] {
        Self.allCases.map { Constants.kindsDictionary[$0.rawValue] ?? "" }
    }
}

// MARK: - AnimeFilterStatus

enum AnimeFilterStatus: String, FilterDescriptableProtocol {
    case all
    case anons
    case ongoing
    case released
    case latest

    // MARK: - Properties

    static var descriptions: [String] {
        Self.allCases.map { Constants.animeStatusDictionary[$0.rawValue] ?? "" }
    }
}

// MARK: - MangaFilterStatus

enum MangaFilterStatus: String, FilterDescriptableProtocol {
    case all
    case anons
    case ongoing
    case released
    case paused
    case discontinued

    // MARK: - Properties

    static var descriptions: [String] {
        Self.allCases.map { Constants.mangaStatusDictionary[$0.rawValue] ?? "" }
    }
}

// MARK: - RanobeFilterStatus

enum RanobeFilterStatus: String, FilterDescriptableProtocol {
    case all
    case anons
    case ongoing
    case released
    case paused
    case discontinued

    // MARK: - Properties

    static var descriptions: [String] {
        Self.allCases.map { Constants.mangaStatusDictionary[$0.rawValue] ?? "" }
    }
}

// MARK: - Seasons

enum Seasons: String, FilterProtocol {
    case spring = "Весна"
    case summer = "Лето"
    case fall = "Осень"
    case winter = "Зима"

    // MARK: - Properties

    static var descriptions: [String] { Self.allCases.map { $0.rawValue } }
    var value: String? {
        switch self {
        case .fall:
            return "fall"
        case .spring:
            return "spring"
        case .summer:
            return "summer"
        case .winter:
            return "winter"
        }
    }
}

// MARK: - Ratings

enum Ratings: String, FilterProtocol {
    case any = "Любая"
    case atLeast9 = "9"
    case atLeast8 = "8"
    case atLeast7 = "7"
    case atLeast6 = "6"
    case atLeast5 = "5"
    case atLeast4 = "4"
    case atLeast3 = "3"
    case atLeast2 = "2"
    case atLeast1 = "1"

    // MARK: - Properties

    static var descriptions: [String] { Self.allCases.map { $0.rawValue } }
    var value: Int? {
        switch self {
        case .any:
            return nil
        case .atLeast1:
            return 1
        case .atLeast2:
            return 2
        case .atLeast3:
            return 3
        case .atLeast4:
            return 4
        case .atLeast5:
            return 5
        case .atLeast6:
            return 6
        case .atLeast7:
            return 7
        case .atLeast8:
            return 8
        case .atLeast9:
            return 9
        }
    }
}
