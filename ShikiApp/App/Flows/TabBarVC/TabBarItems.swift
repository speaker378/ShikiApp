//
//  TabBarItem.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

enum TabBarItems: Int {
    case home
    case search
    case myList
    case profile
    
    var title: String {
        switch self {
        case .home:
            return Texts.TabBarTitles.home
        case .search:
            return Texts.TabBarTitles.search
        case .myList:
            return Texts.TabBarTitles.myList
        case .profile:
            return Texts.TabBarTitles.profile
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .home:
            return AppImage.TabBarIcons.home
        case .search:
            return AppImage.TabBarIcons.search
        case .myList:
            return AppImage.TabBarIcons.myList
        case .profile:
            return AppImage.TabBarIcons.profile
        }
    }
    
    var selectedIconImage: UIImage {
        switch self {
        case .home:
            return AppImage.TabBarIcons.homeSelected
        case .search:
            return AppImage.TabBarIcons.searchSelected
        case .myList:
            return AppImage.TabBarIcons.myListSelected
        case .profile:
            return AppImage.TabBarIcons.profileSelected
        }
    }
    
}
