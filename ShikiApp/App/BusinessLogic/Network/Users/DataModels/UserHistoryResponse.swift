//
//  UserHistoryResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 23.01.2023.
//

import Foundation

typealias UserHistoryResponse = [HistoryItem]

struct HistoryItem: Codable {
    let id: Int
    let createdAt, description: String
    let target: Target

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case description, target
    }
}

// MARK: - Target
struct Target: Codable {
    let id: Int
    let name, russian: String
    let image: Image
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
