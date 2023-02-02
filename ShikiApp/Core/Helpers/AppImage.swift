//
//  AppImage.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
//  Класс для создания UIImage
//  Пример использования:
//   let image = AppImage.ErrorsIcons.nonConnectionIcon

import UIKit

enum AppImage {
    
    private static let missingImage = UIImage()

    // MARK: - NavigationsBarIcons
    
    enum NavigationsBarIcons {
        static let back = UIImage(named: "back") ?? missingImage
        static let cancel = UIImage(named: "cancel") ?? missingImage
        static let chevronBigRight = UIImage(named: "chevronBigRight") ?? missingImage
        static let chevronDown = UIImage(named: "chevronDown") ?? missingImage
        static let done = UIImage(named: "done") ?? missingImage
        static let login = UIImage(named: "login") ?? missingImage
        static let logout = UIImage(named: "logout") ?? missingImage
        static let search = UIImage(named: "search_nav") ?? missingImage
        static let share = UIImage(named: "share") ?? missingImage
    }
    
    // MARK: - UserListsIcons
    
    enum UserListIcons {
        static let watching = UIImage(named: "watching") ?? missingImage
        static let watched = UIImage(named: "watched") ?? missingImage
        static let rewatching = UIImage(named: "rewatching") ?? missingImage
        static let dropped = UIImage(named: "dropped") ?? missingImage
        static let star = UIImage(named: "star") ?? missingImage
        static let starFilled = UIImage(named: "starFilled") ?? missingImage
        static let plus = UIImage(named: "plus") ?? missingImage
        static let minus = UIImage(named: "minus") ?? missingImage
    }

    // MARK: - ErrorsIcons
    
    enum ErrorsIcons {
        static let nonConnectionIcon = UIImage(named: "noConnectionIcon") ?? missingImage
        static let noUserpicIcon = UIImage(named: "noUserpic") ?? missingImage
        static let noResults = UIImage(named: "noResults") ?? missingImage
    }

    // MARK: - TabBarIcons
    
    enum TabBarIcons {
        static let home = UIImage(named: "home") ?? missingImage
        static let homeSelected = UIImage(named: "homeSelected") ?? missingImage
        static let myList = UIImage(named: "myList") ?? missingImage
        static let myListSelected = UIImage(named: "myListSelected") ?? missingImage
        static let profile = UIImage(named: "profile") ?? missingImage
        static let profileSelected = UIImage(named: "profileSelected") ?? missingImage
        static let search = UIImage(named: "search") ?? missingImage
        static let searchSelected = UIImage(named: "searchSelected") ?? missingImage
    }
    
    enum OtherIcons {
        static let link = UIImage(named: "link") ?? missingImage
        static let addToList = UIImage(named: "addToList") ?? missingImage
    }
}
