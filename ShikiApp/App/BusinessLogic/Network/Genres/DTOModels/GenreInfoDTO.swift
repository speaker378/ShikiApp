//
//  GenreInfoDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.02.2023.
//

import Foundation

// MARK: - GenreInfoDTO

struct GenreInfoDTO: Codable {

    // MARK: - Properties

    let id: Int
    let name: String
    let russian: String?
    let kind: String?
}
