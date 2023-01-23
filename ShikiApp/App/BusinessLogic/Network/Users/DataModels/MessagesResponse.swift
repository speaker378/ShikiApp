//
//  MessagesResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

typealias MessagesResponse = [Message]

// MARK: - Message
struct Message: Codable {
    let id: Int
    let kind: String
    let read: Bool
    let body, htmlBody, createdAt: String
    let linkedID: Int
    let linkedType: String
    let linked: LinkedData
    let source, target: User

    enum CodingKeys: String, CodingKey {
        case id, kind, read, body
        case htmlBody = "html_body"
        case createdAt = "created_at"
        case linkedID = "linked_id"
        case linkedType = "linked_type"
        case linked
        case source = "from"
        case target = "to"
    }
}

// MARK: - Linked
struct LinkedData: Codable {
    let id: Int
    let topicURL: String
    let threadID, topicID: Int
    let type, name, russian: String
    let image: Image
    let url, kind, score, status: String
    let episodes, episodesAired: Int
    let airedOn, releasedOn: String

    enum CodingKeys: String, CodingKey {
        case id
        case topicURL = "topic_url"
        case threadID = "thread_id"
        case topicID = "topic_id"
        case type, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}
