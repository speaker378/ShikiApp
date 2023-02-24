//
//  UserRatesRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 24.02.2023.
//

import Foundation

// MARK: - UserRatesRequestFactoryProtocol

protocol UserRatesRequestFactoryProtocol {

    // MARK: - Properties

    var delegate: (AbstractRequestFactory<UserRatesApi>)? { get }

    // MARK: - Functions

    func getList(
        page: Int?,
        limit: Int?,
        userId: Int,
        targetId: Int?,
        targetType: UserRatesTargetType?,
        status: UserRatesStatus?,
        completion: @escaping (_ response: UserRatesResponseDTO?, _ error: String?) -> Void
    )

    func getById(id: Int, completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void)
    
    func postEntity(
        userId: Int,
        targetId: Int,
        targetType: UserRatesTargetType,
        state: UserRatesState?,
        completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void
    )
    
    func putEntity(
        id: Int,
        state: UserRatesState,
        completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void
    )
    
    func postIncrement(
        id: Int,
        completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void
    )
}

// MARK: - UserRatesRequestFactoryProtocol extension

extension UserRatesRequestFactoryProtocol {

    // MARK: - Functions

    func getList(
        page: Int? = nil,
        limit: Int? = nil,
        userId: Int,
        targetId: Int? = nil,
        targetType: UserRatesTargetType? = nil,
        status: UserRatesStatus? = nil,
        completion: @escaping (_ response: UserRatesResponseDTO?, _ error: String?) -> Void
    ) {
        let parameters = validateListParameters(
            page: page,
            limit: limit,
            userId: userId,
            targetId: targetId,
            targetType: targetType,
            status: status
        )
        delegate?.getResponse(
            type: UserRatesResponseDTO.self,
            endPoint: .getList(parameters: parameters),
            completion: completion
        )
    }

    func getById(id: Int, completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: UserRatesDTO.self, endPoint: .getById(id: id), completion: completion)
    }

    func postEntity(
        userId: Int,
        targetId: Int,
        targetType: UserRatesTargetType,
        state: UserRatesState? = nil,
        completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void
    ) {
        let parameters = validatePostParameters(
            userId: userId,
            targetId: targetId,
            targetType: targetType,
            status: state?.status,
            score: state?.score,
            chapters: state?.chapters,
            episodes: state?.episodes,
            volumes: state?.volumes,
            rewathes: state?.rewatches,
            text: state?.text
        )
        delegate?.getResponse(
            type: UserRatesDTO.self,
            endPoint: .postUserRates(parameters: parameters),
            completion: completion
        )
    }

    func putEntity (
        id: Int,
        state: UserRatesState,
        completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void
    ) {
        let parameters = validatePutParameters(
            status: state.status,
            score: state.score,
            chapters: state.chapters,
            episodes: state.episodes,
            volumes: state.volumes,
            rewathes: state.rewatches,
            text: state.text
        )
        delegate?.getResponse(
            type: UserRatesDTO.self,
            endPoint: .putUserRates(id: id, parameters: parameters),
            completion: completion
        )
    }
    
    func postIncrement(
        id: Int,
        completion: @escaping (_ response: UserRatesDTO?, _ error: String?) -> Void
        ) {
            delegate?.getResponse(
                type: UserRatesDTO.self,
                endPoint: .postIncrement(id: id),
                completion: completion
            )
    }
    
    func deleteEntity(
        id: Int,
        completion: @escaping (_ response: String?, _ error: String?) -> Void
        ) {
            delegate?.getResponse(
                type: String.self,
                endPoint: .deleteUserRates(id: id),
                completion: completion
            )
    }

    // MARK: - Private functions

    private func validatePutParameters(
        status: UserRatesStatus? = nil,
        score: Int? = nil,
        chapters: Int? = nil,
        episodes: Int? = nil,
        volumes: Int? = nil,
        rewathes: Int? = nil,
        text: String? = nil
    ) -> Parameters {
        var parameters = Parameters()
        if let score {
            parameters[APIKeys.score.rawValue] = "\(score)"
        }
        if let status {
            parameters[APIKeys.status.rawValue] = status.rawValue
        }
        if let chapters {
            parameters[APIKeys.chapters.rawValue] = "\(chapters)"
        }
        if let episodes {
            parameters[APIKeys.episodes.rawValue] = "\(episodes)"
        }
        if let volumes {
            parameters[APIKeys.volumes.rawValue] = "\(volumes)"
        }
        if let rewathes {
            parameters[APIKeys.rewatches.rawValue] = "\(rewathes)"
        }
        if let text {
            parameters[APIKeys.text.rawValue] = text
        }
        return parameters
    }
    
    private func validatePostParameters(
        userId: Int,
        targetId: Int,
        targetType: UserRatesTargetType,
        status: UserRatesStatus? = nil,
        score: Int? = nil,
        chapters: Int? = nil,
        episodes: Int? = nil,
        volumes: Int? = nil,
        rewathes: Int? = nil,
        text: String? = nil
    ) -> Parameters {
        var parameters = Parameters()
        parameters[APIKeys.userId.rawValue] = "\(userId)"
        parameters[APIKeys.targetId.rawValue] = "\(targetId)"
        parameters[APIKeys.targetType.rawValue] = targetType.rawValue
        let addidionalParameters = validatePutParameters(
            status: status,
            score: score,
            chapters: chapters,
            episodes: episodes,
            volumes: volumes,
            rewathes: rewathes,
            text: text
        )
        parameters.merge(addidionalParameters) { $1 }
        return parameters
    }
    
    private func validateListParameters(page: Int?,
                                        limit: Int?,
                                        userId: Int,
                                        targetId: Int?,
                                        targetType: UserRatesTargetType?,
                                        status: UserRatesStatus?) -> Parameters {
        var parameters = Parameters()
        if let page, (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
            parameters[APIKeys.page.rawValue] = page
        }
        if let limit,
           (1 ... APIRestrictions.limit1000.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
        }
        parameters[APIKeys.userId.rawValue] = userId
        if let targetId {
            parameters[APIKeys.targetId.rawValue] = targetId
        }
        if let targetType {
            parameters[APIKeys.targetType.rawValue] = targetType.rawValue
        }
        if let status {
            parameters[APIKeys.status.rawValue] = status.rawValue
        }
        return parameters
    }
}

// MARK: - UserRatesRequestFactory

final class UserRatesRequestFactory: UserRatesRequestFactoryProtocol {

    // MARK: - Properties

    let delegate: (AbstractRequestFactory<UserRatesApi>)?

    // MARK: - Construction

    init() {
        delegate = AbstractRequestFactory<UserRatesApi>()
    }
}
