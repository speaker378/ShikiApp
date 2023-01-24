//
//  UnreadMessagesResaponseDTO.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation

// MARK: - UnreadMessagesResaponseDTO

struct UnreadMessagesResaponseDTO: Codable {
    let messages, news, notifications: Int
}
