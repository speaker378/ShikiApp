//
//  UserRatesEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 24.02.2023.
//

import Foundation

// MARK: - UserRatesStatus

typealias UserRatesStatus = UserContentState

// MARK: - UserRatesTargetType

enum UserRatesTargetType: String {
    case anime = "Anime", manga = "Manga"
}
