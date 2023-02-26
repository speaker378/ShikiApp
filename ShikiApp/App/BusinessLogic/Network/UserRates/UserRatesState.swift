//
//  UserRatesState.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 24.02.2023.
//

import Foundation

// MARK: - UserRatesState

struct UserRatesState {
    
    let status: UserRatesStatus?
    let score: Int?
    let chapters: Int?
    let episodes: Int?
    let volumes: Int?
    let rewatches: Int?
    let text: String?
}
