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
        print("Select Filters screen will be displayed here")
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

    func viewDidSelectEntity(entity _: SearchModel) {
        print("Entity details screen build will be done here\n entity type see self.layer,\n entityId see entity.id")
    }

    func fetchData() {
        fetchFirstPage()
    }

    // MARK: - Private functions

    private func refreshView() {
        switch page {
        case 0:
            viewInput?.models.removeAll()
        case 1:
            viewInput?.models = SearchModelFactory().makeModels(from: entityList)
        default:
            viewInput?.models.append(contentsOf: SearchModelFactory().makeModels(from: entityList))
        }
        viewInput?.tableHeader = buildHeader()
    }
    
    private func buildHeader() -> String {
        if (searchString ?? "").isEmpty {
            return "\(Constants.SearchHeader.emptyStringResult) \(layer.rawValue.lowercased())"
        }
        if page == 0 && entityList.isEmpty {
            return ""
        }
        if (1 ..< pageSize).contains(entityList.count) {
            return "\(Constants.SearchHeader.exactResult) \(entityList.count + pageSize * (page - 1))"
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
