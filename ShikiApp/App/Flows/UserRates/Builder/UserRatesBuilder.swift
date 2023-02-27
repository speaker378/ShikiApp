//
//  UserRatesBuilder.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

final class UserRatesBuilder {
    
    static func build() -> (UIViewController & UserRatesViewInput) {
        let presenter = UserRatesPresenter()
        let viewController = UserRatesViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        return viewController
    }
}
