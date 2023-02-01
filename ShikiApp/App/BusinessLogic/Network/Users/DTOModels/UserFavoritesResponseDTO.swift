//
//  UserFavoritesResponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - UserFavoritesResponseDTO

struct UserFavoritesResponseDTO: Codable {
    
    let animes: [FavoriteDTO]
    let mangas: [FavoriteDTO]
    let ranobe: [FavoriteDTO]
    let characters: [FavoriteDTO]
    let people: [FavoriteDTO]
    let mangakas: [FavoriteDTO]
//    let seoyu: [FavoriteDTO]
    let producers: [FavoriteDTO]
}

// MARK: - FavoriteDTO

struct FavoriteDTO: Codable {
    
    let id: Int
    let name: String?
    let russian: String?
    let image: String?
    let url: String?
}
