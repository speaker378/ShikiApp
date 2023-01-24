//
//  TopicsResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

// MARK: - TopicsResponseDTO

typealias TopicsResponseDTO = [TopicDTO]

// MARK: - TopicDTO

struct TopicDTO: Codable {
    let id: Int
    let topicTitle, body, htmlBody, htmlFooter: String?
    let createdAt: String
    let commentsCount: Int?
    let forum: ForumDTO?
    let user: UserDTO?
    let type: String?
    let linkedID: Int?
    let linkedType: String?
    let linked: Linked?
    let viewed: Bool?
    let lastCommentViewed: Bool?
    let event: String?
    let episode: Int?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case topicTitle = "topic_title"
        case body
        case htmlBody = "html_body"
        case htmlFooter = "html_footer"
        case createdAt = "created_at"
        case commentsCount = "comments_count"
        case forum
        case user
        case type
        case linkedID = "linked_id"
        case linkedType = "linked_type"
        case linked, viewed
        case lastCommentViewed = "last_comment_viewed"
        case event, episode, url
    }
}

// MARK: - Linked

struct Linked: Codable {
    let id: Int
    let name, russian: String
    let image: ImageDTO
    let url, kind, score, status: String?
    let episodes, episodesAired: Int?
    let airedOn, releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}

// MARK: - ImageDTO

struct ImageDTO: Codable {
    let original, preview, x96, x48: String
}

// MARK: - UserImageDTO

struct UserImageDTO: Codable {
    let x160, x148, x80, x64: String
    let x48, x32, x16: String
}
