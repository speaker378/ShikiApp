//
//  AnimeListFilters.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 30.01.2023.
//

import Foundation

// MARK: - AnimeListFilters

struct AnimeListFilters {
    var kind: AnimeContentKind?
    var status: AnimeContentStatus?
    var season: String?
    var score: Int?
    var genre: [Int]?
}
