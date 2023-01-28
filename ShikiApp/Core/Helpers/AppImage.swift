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
        static let add = UIImage(named: "add") ?? missingImage
        static let back = UIImage(named: "back") ?? missingImage
        static let cancel = UIImage(named: "cancel") ?? missingImage
        static let chevronBigRight = UIImage(named: "chevronBigRight") ?? missingImage
        static let chevronDown = UIImage(named: "chevronDown") ?? missingImage
        static let done = UIImage(named: "done") ?? missingImage
        static let edit = UIImage(named: "edit") ?? missingImage
        static let login = UIImage(named: "login") ?? missingImage
        static let logout = UIImage(named: "logout") ?? missingImage
        static let search = UIImage(named: "search_nav") ?? missingImage
        static let share = UIImage(named: "share") ?? missingImage
    }

    // MARK: - ErrorsIcons
    
    enum ErrorsIcons {
        static let nonConnectionIcon = UIImage(named: "noConnectionIcon") ?? missingImage
        static let noUserpicIcon = UIImage(named: "noUserpic") ?? missingImage
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
    }
    
}
