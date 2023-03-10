//
//  FiltersBuilder.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

// MARK: - FiltersBuilder

final class FiltersBuilder {

    // MARK: - Functions

    static func build(consumer: FilterConsumerProtocol, filters: FiltersModel) -> (UIViewController & FiltersViewInput) {
        let presenter = FiltersPresenter()
        let viewController = FiltersViewController(presenter: presenter, filters: filters)
        presenter.consumer = consumer
        presenter.viewInput = viewController
        return viewController
    }
}
