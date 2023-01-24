//
//  BansResponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 23.01.2023.
//

import Foundation

// MARK: - BansResponseDTO

typealias BansResponseDTO = [BanDTO]

// MARK: - BanDTO

struct BanDTO: Codable {
    let id, userID: Int
    let comment: CommentDTO
    let moderatorID: Int
    let reason, createdAt: String
    let durationMinutes: Int
    let user, moderator: UserDTO

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case comment
        case moderatorID = "moderator_id"
        case reason
        case createdAt = "created_at"
        case durationMinutes = "duration_minutes"
        case user, moderator
    }
}

// MARK: - CommentDTO

struct CommentDTO: Codable {
    let id, commentableID: Int
    let commentableType, body: String
    let userID: Int
    let createdAt, updatedAt: String
    let isOfftopic: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case commentableID = "commentable_id"
        case commentableType = "commentable_type"
        case body
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isOfftopic = "is_offtopic"
    }
}
