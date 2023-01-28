//
//  NewsfeedBuilder.swift
//  ShikiApp
//
//  Created by Сергей Черных on 23.01.2023.
//

import UIKit

class NewsfeedBuilder {
    
    static func build() -> (UIViewController & NewsfeedViewInput) {
        let presenter = NewsfeedPresenter()
        let viewController = NewsfeedViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        return viewController
    }
}
