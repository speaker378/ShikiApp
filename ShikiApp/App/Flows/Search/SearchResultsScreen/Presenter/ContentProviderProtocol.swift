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
    func getFiltersCounter() -> Int
    func getFilters() -> Any?
    func getGenres() -> [Int]?
    func setGenres(genres: [Int]?)
    func fetchData(searchString: String?, page: Int, completion: @escaping (_ response: [SearchContentProtocol]?, _ error: String?) -> Void )
    func fetchDetailData(id: Int, completion: @escaping (
        _ response: SearchDetailContentProtocol?,
        _ error: String?
    ) -> Void)
}
