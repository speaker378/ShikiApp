//
//  RanobeProvider.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 04.02.2023.
//

import Foundation

// MARK: - RanobeProvider

final class RanobeProvider: ContentProviderProtocol {

    typealias ContentKind = RanobeContentKind
    typealias ContentStatus = RanobeContentStatus

    // MARK: - Private properties
    
    private let factory = ApiFactory.makeRanobeApi()

    // MARK: - Properties

    var filters: RanobeListFilters?

    // MARK: - Functions

    func setFilters(filters: Any?) -> Int {
        self.filters = filters as? RanobeListFilters
        return getFiltersCount()
    }
    
    func getFilters() -> ListFilters<RanobeContentKind, RanobeContentStatus>? { filters }
    
    func fetchData(searchString: String?, page: Int = 1, completion: @escaping ([SearchContentProtocol]?, String?) -> Void) {
        factory.getRanobes(
            page: page,
            limit: APIRestrictions.limit50.rawValue,
            filters: filters,
            search: searchString,
            order: .byRank,
            completion: completion
        )
    }
    

}
