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
    
    let id, userID, targetID: Int
    let targetType: String
    let score: Int
    let status: String
    let rewatches, episodes, volumes, chapters: Int
    let createdAt, textHTML, updatedAt: String
    let text: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case targetID = "target_id"
        case targetType = "target_type"
        case score, status, rewatches, episodes, volumes, chapters, text
        case textHTML = "text_html"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
