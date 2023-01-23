//
//  ClubsResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

typealias ClubsResponse = [Club]

// MARK: - Club
struct Club: Codable {
    let id: Int
    let name: String
    let logo: Logo
    let isCensored: Bool
    let joinPolicy, commentPolicy: String

    enum CodingKeys: String, CodingKey {
        case id, name, logo
        case isCensored = "is_censored"
        case joinPolicy = "join_policy"
        case commentPolicy = "comment_policy"
    }
}

// MARK: - Logo
typealias Logo = Image
