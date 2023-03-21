//
//  AnimeProvider.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 04.02.2023.
//

import Foundation

// MARK: - AnimeProvider

final class AnimeProvider: ContentProviderProtocol {
    
    typealias ContentKind = AnimeContentKind
    typealias ContentStatus = AnimeContentStatus

    // MARK: - Private properties
    
    private let factory: AnimesRequestFactoryProtocol

    // MARK: - Properties

    var filters: AnimeListFilters?

    // MARK: - Constructions

    init() {
        factory = ApiFactory.makeAnimesApi()
    }

    // MARK: - Functions

    func getGenres() -> [Int]? { filters?.genre }
    
    func setGenres(genres: [Int]?) {
        if filters == nil { filters = AnimeListFilters() }
        filters?.genre = genres
    }
    
    func setFilters(filters: Any?) -> Int {
        self.filters = filters as? AnimeListFilters
        return self.filters?.filtersCount() ?? 0
    }

    func getFiltersCounter() -> Int {
        return self.filters?.filtersCount() ?? 0
    }
    
    func getFilters() -> Any? { filters }

    func fetchData(searchString: String? = nil, page: Int = 1, completion: @escaping (_ response: [SearchContentProtocol]?, _ error: String?) -> Void) {
        factory.getAnimes(
            page: page,
            limit: APIRestrictions.limit50.rawValue,
            filters: filters,
            search: searchString,
            censored: RestrictionsProvider.restrictions.isCensored(),
            order: .byRank,
            completion: completion
        )
    }
    
    func fetchDetailData(
        id: Int,
        completion: @escaping (_ response: SearchDetailContentProtocol?, _ error: String?
        ) -> Void) {
        factory.getAnimeById(id: id, completion: completion)
    }
}
