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
    func viewDidSelectEntity(entity: SearchModel)
    func fetchData()
    func setFilter(filter: Any?)
    func setLayer(layer: SearchContentEnum)
    func setSearchString(searchString: String?)
    func endOfTableReached()
}

// MARK: - SearchPresenter

final class SearchPresenter: SearchViewOutput {

    // MARK: - Properties

    weak var viewInput: (UIViewController & SearchViewInput)?

    // MARK: - Private properties

    private var page = 0
    private let pageSize = APIRestrictions.limit50.rawValue
    private var layer: SearchContentEnum = .anime { didSet { fetchFirstPage() } }
    private var searchString: String? { didSet { fetchFirstPage() } }
    private var errorString: String? { didSet {
        guard let errorString  else {
            viewInput?.hideError()
            return
        }
        viewInput?.showError(errorString: errorString)
    } }
    private var entityList = [SearchContentProtocol]() { didSet { refreshView() } }
    private var isLoading = false
    private let filtersModelFactory = FiltersModelFactory()
    private var providers: [SearchContentEnum: any ContentProviderProtocol] = [
        .anime: AnimeProvider(),
        .manga: MangaProvider(),
        .ranobe: RanobeProvider()
    ]

    // MARK: - Functions

    func endOfTableReached() {
        fetchNextPage()
    }

    func requestFilters() {
        let filtersViewController = FiltersBuilder.build(
            consumer: self,
            filters: filtersModelFactory.buildFiltersModel(layer: layer)
        )
        viewInput?.navigationController?.pushViewController(filtersViewController, animated: true)
    }
    
    func setFilter(filter: Any?) {
        guard let count = providers[layer]?.setFilters(filters: filter) else { return }
        viewInput?.setFiltersCounter(count: count)
        fetchFirstPage()
    }

    func setLayer(layer: SearchContentEnum) {
        self.layer = layer
        guard let count = providers[layer]?.getFiltersCounter() else { return }
        viewInput?.setFiltersCounter(count: count)
    }

    func setSearchString(searchString: String?) {
        self.searchString = searchString
    }

    func viewDidSelectEntity(entity: SearchModel) {
        guard let provider = providers[layer] else { return }
        let searchDetailViewController = SearchDetailBuilder.build(id: entity.id, provider: provider)
        viewInput?.navigationController?.pushViewController(searchDetailViewController, animated: true)
    }

    func fetchData() {
        fetchFirstPage()
    }

    // MARK: - Private functions

    private func refreshView() {
        if !entityList.isEmpty {
            if page > 1 {
                viewInput?.models.append(contentsOf: SearchModelFactory().makeModels(from: entityList))
            } else {
                viewInput?.models = SearchModelFactory().makeModels(from: entityList)
            }
        } else {
            if page == 0 { viewInput?.models.removeAll() }
        }
        viewInput?.tableHeader = buildHeader()
    }
    
    private func buildHeader() -> String {
        if (searchString ?? "").isEmpty && providers[layer]?.getFiltersCounter() ?? 0 == 0 {
            return "\(Constants.SearchHeader.emptyStringResult) \(layer.rawValue.lowercased())"
        }
        if page == 0 && entityList.isEmpty {
            return ""
        }
        if (0 ..< pageSize).contains(entityList.count) {
            return "\(Constants.SearchHeader.exactResult) \(viewInput?.models.count ?? 0)"
        }
        return "\(Constants.SearchHeader.approximateResult)"
    }
    
    private func fetchFirstPage() {
        page = 0
        fetchNextPage()
    }
    
    private func fetchNextPage() {
        if isLoading { return }
        isLoading = true
        providers[layer]?.fetchData(searchString: searchString, page: page + 1) { [weak self] data, error in
            if let data, !data.isEmpty {
                self?.page += 1
                self?.entityList = data
                self?.isLoading = false
                return
            }
            if let error { self?.errorString = error }
            self?.entityList.removeAll()
            self?.isLoading = false
        }
    }
}

extension SearchPresenter: FilterConsumerProtocol {

    // MARK: - Functions

    func applyFilterList(filters: FilterListModel) {
        let filter = filtersModelFactory.buildFilter(filters: filters, layer: layer)
        setFilter(filter: filter)
        viewInput?.navigationController?.popViewController(animated: true)
    }
    
}
