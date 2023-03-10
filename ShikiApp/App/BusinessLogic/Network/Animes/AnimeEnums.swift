//
//  AnimeEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 30.01.2023.
//

import Foundation

enum OrderBy: String {
    case byId = "id"
    case byIdDesc = "id_desc"
    case byRank = "ranked"
    case byPopularity = "popularity"
    case byName = "name"
    case byAiredOn = "aired_on"
    case byEpisodes = "episodes"
    case byStatus = "status"
    case byKind = "kind"
    case random = "random"
}

enum AnimeContentKind: String, CaseIterable, Codable {
    case tvSeries = "tv"
    case movie
    case ova
    case ona
    case special
    case music
    case tv13 = "tv_13"
    case tv24 = "tv_24"
    case tv48 = "tv_48"
}

enum AnimeContentStatus: String, CaseIterable, Codable {
    case anons, ongoing, released, latest
}
