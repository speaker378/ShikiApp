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
        static let addButton = UIImage(named: "addButton")
        static let backButton = UIImage(named: "backButton")
        static let cancelButton = UIImage(named: "cancelButton")
        static let chevronBigRightButton = UIImage(named: "chevronBigRightButton")
        static let chevronDownButton = UIImage(named: "chevronDownButton")
        static let doneButton = UIImage(named: "doneButton")
        static let editButton = UIImage(named: "editButton")
        static let loginButton = UIImage(named: "loginButton")
        static let logoutButton = UIImage(named: "logoutButton")
        static let serchButton = UIImage(named: "serchButton")
        static let shareButton = UIImage(named: "shareButton")
    }
    
    // MARK: - ErrorsIcons
    enum ErrorsIcons {
        static let nonConnectionIcon = UIImage(named: "nonConnectionIcon")
    }
    
    // MARK: - TabBarIcons
    enum TabBarIcons {
        static let homeButton = UIImage(named: "homeButton")
        static let homeButtonSelected = UIImage(named: "homeButtonSelected")
        static let myListButton = UIImage(named: "myListButton")
        static let myListButtonSelected = UIImage(named: "myListButtonSelected")
        static let profileButton = UIImage(named: "profileButton")
        static let profileButtonSelected = UIImage(named: "profileButtonSelected")
        static let searchButton = UIImage(named: "searchButton")
        static let searchButtonSelected = UIImage(named: "searchButtonSelected")
    }
    
}
