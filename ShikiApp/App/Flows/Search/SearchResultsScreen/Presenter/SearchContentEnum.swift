//
//  SearchContentEnum.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import Foundation

enum SearchContentEnum: String, CaseIterable {
    case anime = "Аниме", manga = "Манга", ranobe = "Ранобэ"

    // MARK: - Properties

    var genresFilter: String {
        switch self {
        case .anime:
            return "anime"
        case .manga:
            return "manga"
        case .ranobe:
            return "manga"
        }
    }
}
