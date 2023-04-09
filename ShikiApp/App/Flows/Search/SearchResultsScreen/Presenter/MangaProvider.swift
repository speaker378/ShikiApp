//
//  MangaProvider.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 04.02.2023.
//

import Foundation

// MARK: - MangaProvider

final class MangaProvider: ContentProviderProtocol {

    typealias ContentKind = MangaContentKind
    typealias ContentStatus = MangaContentStatus

    // MARK: - Private properties

    private let factory: MangasRequestFactoryProtocol

    // MARK: - Properties
    
    var filters: MangaListFilters?

    // MARK: - Constructions

    init() {
        factory = ApiFactory.makeMangasApi()
    }

    // MARK: - Functions

    func getGenres() -> [Int]? { filters?.genre }
    
    func setGenres(genres: [Int]?) {
        if filters == nil { filters = MangaListFilters() }
        filters?.genre = genres
    }

    func setFilters(filters: Any?) -> Int {
        self.filters = filters as? MangaListFilters
        return self.filters?.filtersCount() ?? 0
    }
    
    func getFiltersCounter() -> Int {
        return self.filters?.filtersCount() ?? 0
    }
    
    func getFilters() -> Any? { filters }
    
    func fetchData(searchString: String?, page: Int = 1, completion: @escaping ([SearchContentProtocol]?, String?) -> Void) {
        factory.getMangas(
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
        factory.getMangaById(id: id, completion: completion)
    }
}
