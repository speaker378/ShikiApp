//
//  StartManager.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

final class StartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let rootVC = TabBarViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
}
