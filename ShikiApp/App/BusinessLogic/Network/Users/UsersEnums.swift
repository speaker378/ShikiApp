//
//  UsersEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

// MARK: - UserContentState

enum UserContentState: String {
    case planned, watching, reWatching = "rewatching", completed, onHold = "on_hold", dropped
}

// MARK: - UserMessageType

enum UserMessageType: String {
    case inbox, personal = "private", sent, news, notifications
}

// MARK: - TargetType

enum TargetType: String {
    case anime = "Anime", manga = "Manga"
}
