//
//  UserRatesDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 24.02.2023.
//

import Foundation

// MARK: - UserRatesResponseDTO

typealias UserRatesResponseDTO = [UserRatesDTO]

// MARK: - UserRatesDTO

struct UserRatesDTO: Codable {
    
    let id: Int
    let userID, targetID: Int?
    let targetType: String?
    let score: Int
    let status: String
    let rewatches, episodes, volumes, chapters: Int?
    let createdAt, updatedAt: String
    let textHTML, text: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case targetID = "target_id"
        case targetType = "target_type"
        case score, status
        case rewatches, episodes, volumes, chapters
        case text
        case textHTML = "text_html"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
