//
//  AnimeDetailsDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 30.01.2023.
//

import Foundation

// MARK: - AnimeDetailsDTO

struct AnimeDetailsDTO: Codable {
    let id: Int
    let name: String
    let russian: String?
    let image: AnimeImageDTO?
    let url, kind, status: String?
    let score: String?
    let episodes, episodesAired: Int?
    let airedOn, releasedOn: String?
    let rating: String?
    let english, japanese: [String?]
    let synonyms: [String?]
    let licenseNameRu: String?
    let duration: Int?
    let description: String?
    let descriptionHTML: String?
    let descriptionSource, franchise: String?
    let favoured, anons, ongoing: Bool
    let threadID, topicID, myanimelistID: Int?
    let ratesScoresStats: [RatesScoresDTO]
    let ratesStatusesStats: [RatesStatusesDTO]
    let updatedAt: String?
    let nextEpisodeAt: String?
    let fansubbers, fandubbers, licensors: [String?]
    let genres: [GenreDTO]
    let studios: [StudioDTO]
    let videos: [VideoDTO]
    let screenshots: [ScreenshotDTO]
    let userRate: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
        case rating, english, japanese, synonyms
        case licenseNameRu = "license_name_ru"
        case duration, description
        case descriptionHTML = "description_html"
        case descriptionSource = "description_source"
        case franchise, favoured, anons, ongoing
        case threadID = "thread_id"
        case topicID = "topic_id"
        case myanimelistID = "myanimelist_id"
        case ratesScoresStats = "rates_scores_stats"
        case ratesStatusesStats = "rates_statuses_stats"
        case updatedAt = "updated_at"
        case nextEpisodeAt = "next_episode_at"
        case fansubbers, fandubbers, licensors, genres, studios, videos, screenshots
        case userRate = "user_rate"
    }
}

// MARK: - GenreDTO

struct GenreDTO: Codable {
    let id: Int
    let name: String
    let russian: String?
    let kind: String?
}

// MARK: - RatesStatusesDTO

struct RatesStatusesDTO: Codable {
    let name: String
    let value: Int
}

// MARK: - RatesScoresDTO

struct RatesScoresDTO: Codable {
    let name: Int
    let value: Int
}

// MARK: - StudioDTO

struct StudioDTO: Codable {
    let id: Int
    let name: String?
    let filteredName: String?
    let real: Bool
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, real, image, filteredName = "filtered_name"
    }
}

// MARK: - VideoDTO

struct VideoDTO: Codable {
    let id: Int
    let url, imageUrl, playerUrl, name, kind, hosting: String?
    
    enum CodingKeys: String, CodingKey {
        case id, url, imageUrl = "image_url", playerUrl = "player_url", name, kind, hosting
    }
}

// MARK: - ScreenshotDTO

struct ScreenshotDTO: Codable {
    let original, preview: String?
}
