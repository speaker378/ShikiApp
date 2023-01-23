//
//  NewTopicResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

typealias NewsTopicsResponse = [NewsTopic]

// MARK: - New Topic

struct NewsTopic: Codable {
    let id: Int
    let linked: Linked
    let event: String?
    let episode: Int?
    let createdAt: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case linked
        case event, episode, url
        case createdAt = "created_at"
    }
}
