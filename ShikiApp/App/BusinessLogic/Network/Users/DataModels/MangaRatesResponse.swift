//
//  MangaRatesResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

typealias MangaRatesResponse = [MangaRate]

// MARK: - MangaRate
struct MangaRate: Codable {
    let id, score: Int
    let status: String
    let text: String?
    let episodes: Int
    let chapters, volumes: Int?
    let textHTML: String?
    let rewatches: Int
    let createdAt, updatedAt: String?
    let user: User
    let anime: AnimeInfo?
    let manga: MangaInfo

    enum CodingKeys: String, CodingKey {
        case id, score, status, text, episodes, chapters, volumes
        case textHTML = "text_html"
        case rewatches
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, anime, manga
    }
}

// MARK: - Manga
struct MangaInfo: Codable {
    let id: Int
    let name, russian: String
    let image: Image
    let url, kind, score, status: String
    let volumes, chapters: Int
    let airedOn, releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, volumes, chapters
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}
