//
//  ForumsResponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - ForumsResponseDTO

typealias ForumsResponseDTO = [ForumDTO]

// MARK: - ForumDTO

struct ForumDTO: Codable {
    let id: Int
    let position: Int?
    let name: String?
    let permalink: String?
    let url: String?
}
