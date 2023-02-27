//
//  UserResponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

import Foundation

// MARK: - UserResponseDTO

typealias UserResponseDTO = UserDTO

// MARK: - UsersResponseDTO

typealias UsersResponseDTO = [UserDTO]

// MARK: - FriendsResponseDTO

typealias FriendsResponseDTO = UsersResponseDTO

// MARK: - UserDTO

struct UserDTO: Codable {
    
    let id: Int
    let nickname: String
    let avatar: String?
    let image: UserImageDTO?
    let lastOnlineAt: String?
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
