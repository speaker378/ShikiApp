//
//  MangaDetailsDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 31.01.2023.
//

import Foundation

// MARK: - MangaDetailsDTO

struct MangaDetailsDTO: Codable, SearchDetailContentProtocol {
    
    let id: Int
    let name: String
    let russian: String?
    let image: MangaImageDTO?
    let url, kind, status: String?
    let score: String?
    let volumes: Int?
    let chapters: Int?
    let airedOn: String?
    let releasedOn: String?
    let english, japanese: [String?]
    let synonyms: [String?]
    let licenseNameRu: String?
    let description: String?
    let descriptionHTML: String?
    let descriptionSource, franchise: String?
    let favoured, anons, ongoing: Bool?
    let threadID, topicID, myanimelistID: Int?
    let ratesScoresStats: [RatesScoresDTO]?
    let ratesStatusesStats: [RatesStatusesDTO]?
    let licensors: [String]?
    let publishers: [PublisherDTO]?
    let genres: [GenreDTO]?
    let userRate: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, volumes, chapters
        case airedOn = "aired_on"
        case releasedOn = "released_on"
        case english, japanese, synonyms
        case licenseNameRu = "license_name_ru"
        case description
        case descriptionHTML = "description_html"
        case descriptionSource = "description_source"
        case franchise, favoured, anons, ongoing
        case threadID = "thread_id"
        case topicID = "topic_id"
        case myanimelistID = "myanimelist_id"
        case ratesScoresStats = "rates_scores_stats"
        case ratesStatusesStats = "rates_statuses_stats"
        case licensors, genres, publishers
        case userRate = "user_rate"
    }
}

// MARK: - PublisherDTO

struct PublisherDTO: Codable {
    
    let id: Int
    let name: String?
}

// MARK: - MangaImageDTO

typealias MangaImageDTO = ImageDTO
