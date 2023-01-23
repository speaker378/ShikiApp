//
//  UserInfo.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - UserInfo

struct UserProfile: Codable {
    let id: Int
    let nickname, avatar: String
    let image: UserImage
    let lastOnlineAt: String
    let url: String
    let name, sex, fullYears: String?
    let lastOnline, website: String
    let location: String?
    let banned: Bool
    let about, aboutHTML: String
    let commonInfo: [String]
    let showComments: Bool
    let inFriends: Bool
    let isIgnored: Bool
    let stats: Stats
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
        case website, location, banned, about
        case aboutHTML = "about_html"
        case commonInfo = "common_info"
        case showComments = "show_comments"
        case inFriends = "in_friends"
        case isIgnored = "is_ignored"
        case stats
        case styleID = "style_id"
    }
}

// MARK: - Stats

struct Stats: Codable {
    let statuses, fullStatuses, scores, types: FullStatuses
    let ratings: Ratings
    let hasAnime, hasManga: Bool
    let genres, studios, publishers: [String]
    let activity: Activity

    enum CodingKeys: String, CodingKey {
        case statuses
        case fullStatuses = "full_statuses"
        case scores, types, ratings
        case hasAnime = "has_anime?"
        case hasManga = "has_manga?"
        case genres, studios, publishers, activity
    }
}

// MARK: - Activity

struct Activity: Codable {}

// MARK: - FullStatuses

struct FullStatuses: Codable {
    let anime, manga: [Anime]
}

// MARK: - Anime

struct Anime: Codable {
    let id: Int
    let groupedID, name: String
    let size: Int
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case id
        case groupedID = "grouped_id"
        case name, size, type
    }
}

// MARK: - TypeEnum

enum TypeEnum: String, Codable {
    case anime = "Anime"
    case manga = "Manga"
}

// MARK: - Ratings

struct Ratings: Codable {
    let anime: [Rating]
}

struct Rating: Codable {
    let name: String
    let value: Int
}
