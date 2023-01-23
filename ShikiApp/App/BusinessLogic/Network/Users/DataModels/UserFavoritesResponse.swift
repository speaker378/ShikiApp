//
//  UserFavoritesResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - UserFavoritesResponse

struct UserFavoritesResponse: Codable {
    let animes: [Favorite]
    let mangas: [Favorite]
    let ranobe: [Favorite]
    let characters: [Favorite]
    let people: [Favorite]
    let mangakas: [Favorite]
    let seoyu: [Favorite]
    let producers: [Favorite]
}

// MARK: - Favorite

struct Favorite: Codable {
    let id: Int
    let name: String?
    let russian: String?
    let image: String?
    let url: String?
}
