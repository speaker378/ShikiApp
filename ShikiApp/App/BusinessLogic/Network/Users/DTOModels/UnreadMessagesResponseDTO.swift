//
//  UnreadMessagesResaponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - UnreadMessagesResponseDTO

struct UnreadMessagesResponseDTO: Codable {
    let messages, news, notifications: Int
}
