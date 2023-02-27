//
//  MangaListFilters.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 31.01.2023.
//

import Foundation


// MARK: - MangaListFilters

typealias MangaListFilters = ListFilters<MangaContentKind, MangaContentStatus>

struct ListFilters<K, S> {
    var kind: K?
    var status: S?
    var season: String?
    var score: Int?
    var genre: [Int]?
}
