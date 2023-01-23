//
//  AnimeResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//
import Foundation

typealias AnimeRatesResponse = [AnimeRate]

struct AnimeRate: Codable {
    let id, score: Int
    let status: String
    let text: String?
    let episodes: Int
    let chapters, volumes: Int?
    let textHTML: String?
    let rewatches: Int
    let createdAt, updatedAt: String
    let user: User
    let anime: AnimeInfo
    let manga: MangaInfo?

    enum CodingKeys: String, CodingKey {
        case id, score, status, text, episodes, chapters, volumes
        case textHTML = "text_html"
        case rewatches
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, anime, manga
    }
}

// MARK: - Anime
struct AnimeInfo: Codable {
    let id: Int
    let name, russian: String
    let image: AnimeImage
    let url, kind, score, status: String
    let episodes, episodesAired: Int
    let airedOn, releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}

// MARK: - AnimeImage
typealias AnimeImage = Image
