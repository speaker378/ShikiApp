//
//  UserResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

import Foundation

typealias UserResponse = User
typealias UsersResponse = [User]
typealias FriendsResponse = UsersResponse

// MARK: - User

struct User: Codable {
    let id: Int
    let nickname, avatar: String
    let image: UserImage
    let lastOnlineAt: String
    let url: String?
    let name: String?
    let sex: String?
    let webSite: String?
    let birthDate: String?
    let fullYears: Int?
    let locale: String?

    enum CodingKeys: String, CodingKey {
        case id, nickname, avatar, image
        case lastOnlineAt = "last_online_at"
        case url
        case name
        case sex
        case webSite = "website"
        case birthDate = "birth_on"
        case fullYears = "full_years"
        case locale
    }
}
