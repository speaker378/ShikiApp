//
//  FiltersPresenter.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

protocol FiltersViewInput: AnyObject {
    var filters: FiltersModel { get set }
}

protocol FiltersViewOutput: AnyObject {
    func getFilterList(filters: FilterListModel)
}

final class FiltersPresenter: FiltersViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & FiltersViewInput)?

    // MARK: - Functions

    func getFilterList(filters: FilterListModel) {
        print(filters)
    }
}
