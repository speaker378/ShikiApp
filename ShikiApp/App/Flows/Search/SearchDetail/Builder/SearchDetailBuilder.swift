//
//  SearchDetailBuilder.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

// MARK: - SearchBuilder

class SearchDetailBuilder {
    
    static func build(content: SearchDetailModel) -> (UIViewController & SearchDetailViewInput) {
        let presenter = SearchDetailPresenter()
        let viewController = SearchDetailViewController(presenter: presenter, content: content)

        presenter.viewInput = viewController
        return viewController
    }
}
