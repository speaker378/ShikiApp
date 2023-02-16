//
//  SearchPresenter.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import UIKit

// MARK: - SearchViewInput

protocol SearchViewInput: AnyObject {
    
    var models: [SearchModel] { get set }
    var tableHeader: String {get set }
    func showError(errorString: String?)
    func hideError()
    func setFiltersCounter(count: Int)
}

// MARK: - SearchViewOutput

protocol SearchViewOutput: AnyObject {
    
    func requestFilters()
    func viewDidSelectNews(entity: SearchModel)
    func fetchData()
    func setFilter(filter: Any?)
    func setLayer(layer: SearchContentEnum)
    func setSearchString(searchString: String?)
}

// MARK: - SearchPresenter

final class SearchPresenter: SearchViewOutput {

    // MARK: - Properties

    weak var viewInput: (UIViewController & SearchViewInput)?

    // MARK: - Private properties

    private var page = 1
    private let pageSize = APIRestrictions.limit50.rawValue
    private var layer: SearchContentEnum = .anime { didSet { fetchData() } }
    private var searchString: String? { didSet { fetchData() } }
    private var errorString: String? { didSet {
        guard let errorString  else {
            viewInput?.hideError()
            return
        }
        viewInput?.showError(errorString: errorString)
    } }
    private var entityList = [SearchContentProtocol]() {
        didSet {
            viewInput?.models = SearchModelFactory().makeModels(from: entityList)
            viewInput?.tableHeader = buildHeader()
        }
    }
    private var providers: [SearchContentEnum: any ContentProviderProtocol] = [
        .anime: AnimeProvider(),
        .manga: MangaProvider(),
        .ranobe: RanobeProvider()
    ]

    // MARK: - Functions

    func requestFilters() {
        let filtersViewController = FiltersBuilder.build(filters: FiltersModelFactory().filtersList)
        viewInput?.navigationController?.pushViewController(filtersViewController, animated: true)
    }
    
    func setFilter(filter: Any?) {
        guard let count = providers[layer]?.setFilters(filters: filter) else { return }
        viewInput?.setFiltersCounter(count: count)
    }

    func setLayer(layer: SearchContentEnum) {
        self.layer = layer
    }

    func setSearchString(searchString: String?) {
        self.searchString = searchString
    }

    func viewDidSelectNews(entity _: SearchModel) {
        print("Entity details screen will be done here")
    }

    func fetchData() {
        providers[layer]?.fetchData(searchString: searchString, page: page) {[weak self] data, error in
            if let data {
                self?.entityList = data
                self?.errorString  = data.isEmpty ? Texts.ErrorMessage.noResults : nil
                return
            }
            self?.entityList.removeAll()
            self?.errorString = error
        }
    }

    // MARK: - Private functions

    private func buildHeader() -> String {
        if (searchString ?? "").isEmpty {
            return "\(Constants.SearchHeader.emptyStringResult) \(layer.rawValue.lowercased())"
        }
        if page == 1 && entityList.isEmpty {
            return ""
        }
        if (1 ..< pageSize).contains(entityList.count) {
            return "\(Constants.SearchHeader.exactResult) \(entityList.count + pageSize * (page - 1))"
        }
        return "\(Constants.SearchHeader.approximateResult)"
    }
}
