//
//  SearchDetailBuilder.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

// MARK: - SearchDetailBuilder

final class SearchDetailBuilder {
    
    static func build(id: Int, provider: any ContentProviderProtocol) -> (UIViewController & SearchDetailViewInput) {
        let presenter = SearchDetailPresenter(provider: provider)
        let viewController = SearchDetailViewController(presenter: presenter, id: id)
        presenter.viewInput = viewController
        return viewController
    }
}
