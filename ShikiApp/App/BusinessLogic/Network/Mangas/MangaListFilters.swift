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
    
    func filtersCount() -> Int {
        var counter = 0
        if kind != nil { counter += 1 }
        if status != nil { counter += 1 }
        if score != nil { counter += 1 }
        if let genre { counter += genre.count }
        if let season { counter += 1 + season.filter {$0 == Constants.FilterParameters.delimiter}.count }
        return counter
    }
}
