//
//  MangaListFilters.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 31.01.2023.
//

import Foundation

// MARK: - MangaListFilters

struct MangaListFilters {
    var kind: MangaContentKind?
    var status: MangaContentStatus?
    var season: String?
    var score: Int?
    var genre: [Int]?
}
