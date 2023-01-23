//
//  UnreadMessagesResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.01.2023.
//

import Foundation
struct UnreadMessagesResaponse: Codable {
    let messages, news, notifications: Int
}
