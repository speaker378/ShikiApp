//
//  ContentProviderProtocol.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 14.02.2023.
//

import Foundation

// MARK: - ContentProviderProtocol

protocol ContentProviderProtocol: AnyObject {
    
    associatedtype ContentKind: Codable
    associatedtype ContentStatus: Codable

    // MARK: - Properties

    var filters: ListFilters<ContentKind, ContentStatus>? { get set }

    // MARK: - Functions

    func setFilters(filters: Any?) -> Int
    func getFiltersCounter() -> Int
    func getFilters() -> Any?
    func saveFilters()
    func restoreFilters()
    func fetchData(searchString: String?, page: Int, completion: @escaping (_ response: [SearchContentProtocol]?, _ error: String?) -> Void )
    func fetchDetailData(id: Int, completion: @escaping (
        _ response: SearchDetailContentProtocol?,
        _ error: String?
    ) -> Void)
}

extension ContentProviderProtocol {

    // MARK: - Functions

    func saveFilters() {
        UserDefaultsService().save(filters)
    }

    func restoreFilters() {
        filters = UserDefaultsService().restore(ListFilters<ContentKind, ContentStatus>.self)
    }
}
