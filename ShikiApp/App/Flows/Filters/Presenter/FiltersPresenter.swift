//
//  FiltersPresenter.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

// MARK: - FiltersViewInput protocol

protocol FiltersViewInput: AnyObject {
    var filters: FiltersModel { get set }
}

// MARK: - FiltersViewOutput protocol

protocol FiltersViewOutput: AnyObject {
    func getFilterList(filters: FilterListModel)
}

// MARK: - FilterConsumerProtocol

protocol FilterConsumerProtocol: AnyObject {
    func applyFilterList(filters: FilterListModel)
}

// MARK: - FiltersPresenter

final class FiltersPresenter: FiltersViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & FiltersViewInput)?
    weak var consumer: FilterConsumerProtocol?

    // MARK: - Functions

    func getFilterList(filters: FilterListModel) {
        consumer?.applyFilterList(filters: filters)
    }
}
