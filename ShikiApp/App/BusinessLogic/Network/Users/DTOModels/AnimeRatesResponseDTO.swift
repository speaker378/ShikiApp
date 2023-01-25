//
//  AnimeRatesResponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//
import Foundation

typealias AnimeRatesResponseDTO = [AnimeRateDTO]

// MARK: - AnimeRateDTO

struct AnimeRateDTO: Codable {
    let id, score: Int
    let status: String
    let text: String?
    let episodes: Int
    let chapters, volumes: Int?
    let textHTML: String?
    let rewatches: Int
    let createdAt, updatedAt: String
    let user: UserDTO
    let anime: AnimeInfoDTO
    let manga: MangaInfoDTO?

    enum CodingKeys: String, CodingKey {
        case id, score, status, text, episodes, chapters, volumes
        case textHTML = "text_html"
        case rewatches
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, anime, manga
    }
}

// MARK: - AnimeInfoDTO

struct AnimeInfoDTO: Codable {
    let id: Int
    let name: String
    let russian: String?
    let image: AnimeImageDTO?
    let url, kind, score, status: String?
    let episodes, episodesAired: Int?
    let airedOn, releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}

// MARK: - AnimeImageDTO

typealias AnimeImageDTO = ImageDTO
