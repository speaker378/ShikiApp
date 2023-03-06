//
//  MangasRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 31.01.2023.
//

import Foundation

// MARK: - MangasRequestFactoryProtocol

protocol MangasRequestFactoryProtocol {

    // MARK: - Properties

    var delegate: (AbstractRequestFactory<MangasApi>)? { get }

    // MARK: - Functions

    func getMangas(page: Int?, limit: Int?, filters: MangaListFilters?, myList: [UserRatesStatus]?, search: String?, order: OrderBy?, completion: @escaping (_ response: MangaResponseDTO?, _ error: String?) -> Void)

    func getMangaById(id: Int, completion: @escaping (_ response: MangaDetailsDTO?, _ error: String?) -> Void)
}

// MARK: - MangasRequestFactoryProtocol extension

extension MangasRequestFactoryProtocol {

    // MARK: - Functions

    func getMangas(page: Int? = nil,
                   limit: Int? = nil,
                   filters: MangaListFilters? = nil,
                   myList: [UserRatesStatus]? = nil,
                   search: String? = nil,
                   order: OrderBy? = nil,
                   completion: @escaping (_ response: MangaResponseDTO?, _ error: String?) -> Void) {
        
        let parameters = validateListParameters(
            page: page,
            limit: limit,
            filters: filters,
            myList: myList,
            search: search,
            order: order
        )
        delegate?.getResponse(
            type: MangaResponseDTO.self,
            endPoint: .list(parameters: parameters),
            completion: completion
        )
    }

    func getMangaById(id: Int, completion: @escaping (_ response: MangaDetailsDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: MangaDetailsDTO.self, endPoint: .getById(id: id), completion: completion)
    }

    // MARK: - Private functions

    private func validateListParameters(page: Int?, limit: Int?, filters: MangaListFilters?, myList: [UserRatesStatus]?, search: String?, order: OrderBy?) -> Parameters {
        var parameters = Parameters()
        if let page,
           (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
            parameters[APIKeys.page.rawValue] = page
        }
        if let limit,
           (1 ... APIRestrictions.limit50.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
        }
        if let myList {
            parameters[APIKeys.myList.rawValue] = myList.map {$0.rawValue}.joined(separator: ",")
        }
        if let search {
            parameters[APIKeys.search.rawValue] = search
        }
        if let order {
            parameters[APIKeys.order.rawValue] = order.rawValue
        }
        if let filters {
            parameters.merge(validateListFilters(filters: filters)) { _, new in new }
        }
        return parameters
    }

    private func validateListFilters(filters: MangaListFilters) -> Parameters {
        var parameters = Parameters()
        if let kind = filters.kind {
            parameters[APIKeys.kind.rawValue] = kind.rawValue
        }
        if let status = filters.status {
            parameters[APIKeys.status.rawValue] = status.rawValue
        }
        if let season = filters.season {
            parameters[APIKeys.season.rawValue] = season
        }
        if let score = filters.score, (1 ... 9).contains(score) {
            parameters[APIKeys.score.rawValue] = score
        }
        if let genre = filters.genre {
            parameters[APIKeys.genre.rawValue] = genre.map { "\($0)" }.joined(separator: ",")
        }
        return parameters
    }
}

// MARK: - MangasRequestFactory

final class MangasRequestFactory: MangasRequestFactoryProtocol {

    // MARK: - Properties

    let delegate: (AbstractRequestFactory<MangasApi>)?

    // MARK: - Construction

    init() {
        delegate = AbstractRequestFactory<MangasApi>()
    }
}
