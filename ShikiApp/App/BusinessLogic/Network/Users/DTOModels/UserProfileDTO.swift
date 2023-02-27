//
//  UserProfile.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - UserProfileDTO

struct UserProfileDTO: Codable {
    
    let id: Int
    let nickname: String
    let avatar: String?
    let image: UserImageDTO?
    let lastOnlineAt: String?
    let url: String?
    let name, sex: String?
    let fullYears: Int?
    let lastOnline, website: String?
    let location: String?
    let banned: Bool?
    let about, aboutHTML: String?
    let commonInfo: [String?]?
    let showComments: Bool?
    let inFriends: Bool?
    let isIgnored: Bool?
    let stats: StatsDTO?
    let styleID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case avatar
        case image
        case lastOnlineAt = "last_online_at"
        case url, name, sex
        case fullYears = "full_years"
        case lastOnline = "last_online"
        case website
        case location, banned, about
        case aboutHTML = "about_html"
        case commonInfo = "common_info"
        case showComments = "show_comments"
        case inFriends = "in_friends"
        case isIgnored = "is_ignored"
        case stats
        case styleID = "style_id"
    }
}

// MARK: - StatsDTO

struct StatsDTO: Codable {
    
    let statuses, fullStatuses: FullStatusesDTO?
    let scores: RatingsDTO?
    let types: RatingsDTO?
    let ratings: RatingsDTO?
    let hasAnime, hasManga: Bool?
    let genres: [GenreDTO]?
    let studios: [StudioDTO]
    let publishers: [PublisherDTO]?
    let activity: [ActivityDTO]?

    enum CodingKeys: String, CodingKey {
        case statuses
        case fullStatuses = "full_statuses"
        case scores, types
        case ratings
        case hasAnime = "has_anime?"
        case hasManga = "has_manga?"
        case genres, studios, publishers
        case activity
    }
}

// MARK: - ActivityDTO

struct ActivityDTO: Codable {
    let name: [Int]?
    let value: Int?
}

// MARK: - FullStatusesDTO

struct FullStatusesDTO: Codable {
    let anime, manga: [AnimeDTO]?
}

// MARK: - AnimeDTO

struct AnimeDTO: Codable {
    
    let id: Int
    let groupedID, name: String?
    let size: Int?
    let type: TypeEnumDTO

    enum CodingKeys: String, CodingKey {
        case id
        case groupedID = "grouped_id"
        case name, size, type
    }
}

// MARK: - TypeEnumDTO

enum TypeEnumDTO: String, Codable {
    case anime = "Anime"
    case manga = "Manga"
}

// MARK: - RatingsDTO

struct RatingsDTO: Codable {
    let anime: [RatingDTO]?
    let manga: [RatingDTO]?
}

// MARK: - RatingDTO

struct RatingDTO: Codable {
    
    let name: String?
    let value: Int?
}
