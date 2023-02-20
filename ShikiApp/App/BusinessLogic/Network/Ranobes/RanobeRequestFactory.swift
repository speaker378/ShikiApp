//
//  RanobeRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 01.02.2023.
//

import Foundation

// MARK: - RanobeRequestFactoryProtocol

protocol RanobeRequestFactoryProtocol {

    // MARK: - Properties

    var delegate: (AbstractRequestFactory<RanobeApi>)? { get }

    // MARK: - Functions

    func getRanobes(page: Int?, limit: Int?, filters: RanobeListFilters?, search: String?, order: OrderBy?, completion: @escaping (_ response: RanobeResponseDTO?, _ error: String?) -> Void)

    func getRanobeById(id: Int, completion: @escaping (_ response: RanobeDetailsDTO?, _ error: String?) -> Void)
}

// MARK: - RanobeRequestFactoryProtocol extension

extension RanobeRequestFactoryProtocol {

    // MARK: - Functions

    func getRanobes(
        page: Int? = nil,
        limit: Int? = nil,
        filters: RanobeListFilters? = nil,
        search: String? = nil,
        order: OrderBy? = nil,
        completion: @escaping (_ response: RanobeResponseDTO?, _ error: String?) -> Void
    ) {
        let parameters = validateListParameters(
            page: page,
            limit: limit,
            filters: filters,
            search: search,
            order: order
        )
        delegate?.getResponse(
            type: RanobeResponseDTO.self,
            endPoint: .list(parameters: parameters),
            completion: completion
        )
    }

    func getRanobeById(id: Int, completion: @escaping (_ response: RanobeDetailsDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: RanobeDetailsDTO.self, endPoint: .getById(id: id), completion: completion)
    }

    // MARK: - Private functions

    private func validateListParameters(page: Int?, limit: Int?, filters: RanobeListFilters?, search: String?, order: OrderBy?) -> Parameters {
        var parameters = Parameters()
        if let page = page,
           (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
            parameters[APIKeys.page.rawValue] = page
        }
        if let limit = limit,
           (1 ... APIRestrictions.limit50.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
        }
        if let search = search {
            parameters[APIKeys.search.rawValue] = search
        }
        if let order = order {
            parameters[APIKeys.order.rawValue] = order.rawValue
        }
        if let filters = filters {
            parameters.merge(validateListFilters(filters: filters)) { _, new in new }
        }
        return parameters
    }

    private func validateListFilters(filters: RanobeListFilters) -> Parameters {
        var parameters = Parameters()
        if let status = filters.status {
            parameters[APIKeys.status.rawValue] = status.rawValue
        }
        if let season = filters.season {
            parameters[APIKeys.season.rawValue] = season
        }
        if let score = filters.score, (1...9).contains(score) {
            parameters[APIKeys.score.rawValue] = score
        }
        if let genre = filters.genre {
            parameters[APIKeys.genre.rawValue] = genre.map { "\($0)" }.joined(separator: ",")
        }
        return parameters
    }
}

// MARK: - RanobeRequestFactory

final class RanobeRequestFactory: RanobeRequestFactoryProtocol {

    // MARK: - Properties

    let delegate: (AbstractRequestFactory<RanobeApi>)?

    // MARK: - Construction

    init() {
        delegate = AbstractRequestFactory<RanobeApi>()
    }
}
