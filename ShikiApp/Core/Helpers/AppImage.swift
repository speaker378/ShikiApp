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
    
    // MARK: - NavigationsBarIcons
    enum NavigationsBarIcons {
        static let add = UIImage(named: "add")
        static let back = UIImage(named: "back")
        static let cancel = UIImage(named: "cancel")
        static let chevronBigRight = UIImage(named: "chevronBigRight")
        static let chevronDown = UIImage(named: "chevronDown")
        static let done = UIImage(named: "done")
        static let edit = UIImage(named: "edit")
        static let login = UIImage(named: "login")
        static let logout = UIImage(named: "logout")
        static let search = UIImage(named: "search_nav")
        static let share = UIImage(named: "share")
    }
    
    // MARK: - ErrorsIcons
    enum ErrorsIcons {
        static let nonConnectionIcon = UIImage(named: "nonConnectionIcon")
    }
    
    // MARK: - TabBarIcons
    enum TabBarIcons {
        static let home = UIImage(named: "home")
        static let homeSelected = UIImage(named: "homeSelected")
        static let myList = UIImage(named: "myList")
        static let myListSelected = UIImage(named: "myListSelected")
        static let profile = UIImage(named: "profile")
        static let profileSelected = UIImage(named: "profileSelected")
        static let search = UIImage(named: "search")
        static let searchSelected = UIImage(named: "searchSelected")
    }
    
}
