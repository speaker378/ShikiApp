//
//  FiltersBuilder.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

final class FiltersBuilder {
    
    static func build(filters: FiltersModel) -> (UIViewController & FiltersViewInput) {
        let presenter = FiltersPresenter()
        let viewController = FiltersViewController(presenter: presenter, filters: filters)
        
        presenter.viewInput = viewController
        return viewController
    }
}
