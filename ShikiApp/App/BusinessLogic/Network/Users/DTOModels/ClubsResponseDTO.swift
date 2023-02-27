//
//  ClubsResponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - ClubsResponseDTO

typealias ClubsResponseDTO = [ClubDTO]

// MARK: - ClubDTO

struct ClubDTO: Codable {
    
    let id: Int
    let name: String
    let logo: LogoDTO?
    let isCensored: Bool?
    let joinPolicy, commentPolicy: String?

    enum CodingKeys: String, CodingKey {
        case id, name, logo
        case isCensored = "is_censored"
        case joinPolicy = "join_policy"
        case commentPolicy = "comment_policy"
    }
}

// MARK: - LogoDTO

typealias LogoDTO = ImageDTO
