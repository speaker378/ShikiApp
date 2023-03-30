//
//  MangaEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 31.01.2023.
//


import Foundation

enum MangaContentKind: String, CaseIterable, Codable {
    case manga
    case manhwa
    case manhua
    case novel
    case doujin
    case lightNovel = "light_novel"
    case oneShot = "one_shot"
}

enum MangaContentStatus: String, CaseIterable, Codable {
    case anons, ongoing, released, paused, discontinued
}
