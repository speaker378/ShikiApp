//
//  AnimesRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 30.01.2023.
//

import Foundation

// MARK: - AnimesRequestFactoryProtocol

protocol AnimesRequestFactoryProtocol {

    // MARK: - Properties

    var delegate: (AbstractRequestFactory<AnimesApi>)? { get }

    // MARK: - Functions

    func getAnimes(page: Int?, limit: Int?, filters: AnimeListFilters?, search: String?, order: OrderBy?, completion: @escaping (_ response: AnimesResponseDTO?, _ error: String?) -> Void)

    func getAnimeById(id: Int, completion: @escaping (_ response: AnimeDetailsDTO?, _ error: String?) -> Void)
}

// MARK: - AnimesRequestFactoryProtocol extension

extension AnimesRequestFactoryProtocol {

    // MARK: - Functions

    func getAnimes(page: Int? = nil,
                   limit: Int? = nil,
                   filters: AnimeListFilters? = nil,
                   search: String? = nil,
                   order: OrderBy? = nil,
                   completion: @escaping (_ response: AnimesResponseDTO?, _ error: String?) -> Void) {
        let parameters = validateAnimeListParameters(
            page: page,
            limit: limit,
            filters: filters,
            search: search,
            order: order
        )
        delegate?.getResponse(
            type: AnimesResponseDTO.self,
            endPoint: .list(parameters: parameters),
            completion: completion
        )
    }

    func getAnimeById(id: Int, completion: @escaping (_ response: AnimeDetailsDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: AnimeDetailsDTO.self, endPoint: .getById(id: id), completion: completion)
    }

    // MARK: - Private functions

    private func validateAnimeListParameters(page: Int?, limit: Int?, filters: AnimeListFilters?, search: String?, order: OrderBy?) -> Parameters {
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
            parameters.merge(validateAnimeListFilters(filters: filters)) { _, new in new }
        }
        return parameters
    }

    private func validateAnimeListFilters(filters: AnimeListFilters) -> Parameters {
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
        if let score = filters.score, (1...9).contains(score)  {
            parameters[APIKeys.score.rawValue] = score
        }
        if let genre = filters.genre {
            parameters[APIKeys.genre.rawValue] = genre.map { "\($0)" }.joined(separator: ",")
        }
        return parameters
    }
}

// MARK: - AnimesRequestFactory

final class AnimesRequestFactory: AnimesRequestFactoryProtocol {

    // MARK: - Properties

    let delegate: (AbstractRequestFactory<AnimesApi>)?

    // MARK: - Construction

    init(token: String? = nil, agent: String? = nil) {
        delegate = AbstractRequestFactory<AnimesApi>(token: token, agent: agent)
    }
}
