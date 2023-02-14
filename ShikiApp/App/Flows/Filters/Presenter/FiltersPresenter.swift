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

protocol FilterslViewOutput: AnyObject {
    func getFilterList(filrers: FilterListModel)
}

final class FiltersPresenter: FilterslViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & FiltersViewInput)?

    // MARK: - Functions

    func getFilterList(filrers: FilterListModel) {
        print(filrers)
    }
}
