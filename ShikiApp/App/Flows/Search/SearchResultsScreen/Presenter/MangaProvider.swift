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
    
    private let factory = ApiFactory.makeMangasApi()

    // MARK: - Properties
    
    var filters: MangaListFilters?

    // MARK: - Functions

    func setFilters(filters: Any?) -> Int {
        self.filters = filters as? MangaListFilters
        return getFiltersCount()
    }
    
    func getFiltersCounter() -> Int {
        return getFiltersCount()
    }
    
    func getFilters() -> ListFilters<ContentKind, ContentStatus>? { filters }
    
    func fetchData(searchString: String?, page: Int = 1, completion: @escaping ([SearchContentProtocol]?, String?) -> Void) {
        factory.getMangas(
            page: page,
            limit: APIRestrictions.limit50.rawValue,
            filters: filters,
            search: searchString,
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
