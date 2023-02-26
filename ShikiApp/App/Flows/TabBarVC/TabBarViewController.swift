//
//  TabBarViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.01.2023.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItems] = [.home, .search, .myList, .profile]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .home:
                let newsViewController = NewsfeedBuilder.build()
                return self.wrappedInNavigationController(with: newsViewController, title: $0.title)
            case .search:
                let searchViewController = SearchBuilder.build()
                 return self.wrappedInNavigationController(with: searchViewController, title: $0.title)
            case .myList:
                let myListViewController = MyListViewController()
                return self.wrappedInNavigationController(with: myListViewController, title: $0.title)
            case .profile:
                let profileViewController = ProfileBuilder.build()
                return self.wrappedInNavigationController(with: profileViewController, title: $0.title)
            }
        }
        
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = dataSource[$0].iconImage
            $1.tabBarItem.selectedImage = dataSource[$0].selectedIconImage
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        }
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = AppColor.accent
        tabBarAppearance.backgroundColor = AppColor.backgroundMain
        tabBarAppearance.compactInlineLayoutAppearance.normal.iconColor = AppColor.textMain
        tabBarAppearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: AppColor.textMain,
            .font: AppFont.openSansFont(ofSize: 11)
        ]
        tabBarAppearance.inlineLayoutAppearance.normal.iconColor = AppColor.textMain
        tabBarAppearance.inlineLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: AppColor.textMain,
            .font: AppFont.openSansFont(ofSize: 11)
        ]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = AppColor.textMain
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: AppColor.textMain,
            .font: AppFont.openSansFont(ofSize: 11)
        ]
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: String) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: with)
        navVC.navigationBar.barTintColor = AppColor.textMain
        navVC.navigationBar.backgroundColor = AppColor.backgroundMain
        navVC.navigationBar.isTranslucent = true
        navVC.navigationBar.prefersLargeTitles = true
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.backgroundColor = AppColor.backgroundMain
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: AppFont.openSansFont(ofSize: 20, weight: .semiBold),
            NSAttributedString.Key.foregroundColor: AppColor.textMain
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: AppFont.openSansFont(ofSize: 28, weight: .extraBold),
            NSAttributedString.Key.foregroundColor: AppColor.textMain
        ]
        with.navigationItem.title = title
        with.view.backgroundColor = AppColor.backgroundMain
        
        return navVC
    }
}
