//
//  AnimeProvider.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 04.02.2023.
//

import Foundation

// MARK: - ContentProviderProtocol

protocol ContentProviderProtocol {
    
    associatedtype ContentKind
    associatedtype ContentStatus
    var filters: ListFilters<ContentKind, ContentStatus>? { get }

    func setFilters(filters: Any?) -> Int
    func getFilters() -> ListFilters<ContentKind, ContentStatus>?
    func fetchData(searchString: String?, page: Int, completion: @escaping (_ response: [SearchContent]?, _ error: String?) -> Void )
}

extension ContentProviderProtocol {
    
    internal func getFiltersCount() -> Int {
        guard var filters else { return 0 }
        if let genres = filters.genre, genres.isEmpty { filters.genre = nil }
        if (filters.season ?? "").isEmpty { filters.season = nil }
        return Mirror(reflecting: filters)
            .children
            .filter({ $0.label != nil })
            .filter({Mirror(reflecting: $0.value).children.count > 0})
            .count
    }
}

// MARK: - AnimeProvider

final class AnimeProvider: ContentProviderProtocol {
    
    typealias ContentKind = AnimeContentKind
    typealias ContentStatus = AnimeContentStatus

    // MARK: - Private properties
    
    private let factory = ApiFactory.makeAnimesApi()

    // MARK: - Internal properties

    internal var filters: AnimeListFilters?

    // MARK: - Functions

    func setFilters(filters: Any?) -> Int {
        self.filters = filters as? AnimeListFilters
        return getFiltersCount()
    }

    func getFilters() -> ListFilters<ContentKind, ContentStatus>? { filters }

    func fetchData(searchString: String? = nil, page: Int = 1, completion: @escaping (_ response: [SearchContent]?, _ error: String?) -> Void) {
        factory.getAnimes(
            page: page,
            limit: APIRestrictions.limit50.rawValue,
            filters: filters,
            search: searchString,
            order: .byRank,
            completion: completion
        )
    }
}
