//
//  NewTopic.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

// MARK: - NewTopicRequestDTO

struct NewTopicRequestDTO: Codable {
    let topic: NewTopicDTO?
}

// MARK: - NewTopicDTO

struct NewTopicDTO: Codable {
    
    let body, linkedType, title, type: String?
    let forumID, linkedID: Int?
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case body
        case forumID = "forum_id"
        case linkedID = "linked_id"
        case linkedType = "linked_type"
        case title, type
        case userID = "user_id"
    }
}
