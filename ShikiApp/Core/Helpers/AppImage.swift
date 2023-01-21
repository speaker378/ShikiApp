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
    
    private static let missingImege = UIImage()
    
    // MARK: - NavigationsBarIcons
    enum NavigationsBarIcons {
        static let add = UIImage(named: "add") ?? missingImege
        static let back = UIImage(named: "back") ?? missingImege
        static let cancel = UIImage(named: "cancel") ?? missingImege
        static let chevronBigRight = UIImage(named: "chevronBigRight") ?? missingImege
        static let chevronDown = UIImage(named: "chevronDown") ?? missingImege
        static let done = UIImage(named: "done") ?? missingImege
        static let edit = UIImage(named: "edit") ?? missingImege
        static let login = UIImage(named: "login") ?? missingImege
        static let logout = UIImage(named: "logout") ?? missingImege
        static let search = UIImage(named: "search_nav") ?? missingImege
        static let share = UIImage(named: "share") ?? missingImege
    }
    
    // MARK: - ErrorsIcons
    enum ErrorsIcons {
        static let nonConnectionIcon = UIImage(named: "noConnectionIcon") ?? missingImege
        static let noUserpicIcon = UIImage(named: "noUserpic") ?? missingImege
    }
    
    // MARK: - TabBarIcons
    enum TabBarIcons {
        static let home = UIImage(named: "home") ?? missingImege
        static let homeSelected = UIImage(named: "homeSelected") ?? missingImege
        static let myList = UIImage(named: "myList") ?? missingImege
        static let myListSelected = UIImage(named: "myListSelected") ?? missingImege
        static let profile = UIImage(named: "profile") ?? missingImege
        static let profileSelected = UIImage(named: "profileSelected") ?? missingImege
        static let search = UIImage(named: "search") ?? missingImege
        static let searchSelected = UIImage(named: "searchSelected") ?? missingImege
    }
    
    enum OtherIcons {
        static let link = UIImage(named: "link") ?? missingImege
    }
    
}
