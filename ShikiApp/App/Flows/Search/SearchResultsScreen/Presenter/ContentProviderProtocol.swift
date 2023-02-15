//
//  ContentProviderProtocol.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 14.02.2023.
//

import Foundation

// MARK: - ContentProviderProtocol

protocol ContentProviderProtocol {
    
    associatedtype ContentKind
    associatedtype ContentStatus

    // MARK: - Properties

    var filters: ListFilters<ContentKind, ContentStatus>? { get }

    // MARK: - Functions

    func setFilters(filters: Any?) -> Int
    func getFilters() -> ListFilters<ContentKind, ContentStatus>?
    func fetchData(searchString: String?, page: Int, completion: @escaping (_ response: [SearchContentProtocol]?, _ error: String?) -> Void )
}

extension ContentProviderProtocol {

    // MARK: - Functions

    func getFiltersCount() -> Int {
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
