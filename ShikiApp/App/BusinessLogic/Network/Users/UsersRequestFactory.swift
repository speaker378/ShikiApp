//
//  UsersRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

// MARK: - UsersRequestFactoryProtocol

protocol UsersRequestFactoryProtocol {

    // MARK: - Properties
    
    var delegate: (AbstractRequestFactory<UsersApi>)? { get }

    // MARK: - Functions
    
    func getUsers(page: Int?, limit: Int?, completion: @escaping (_ response: UsersResponseDTO?, _ error: String?) -> Void)
    
    func getUserById(id: Int, completion: @escaping (_ response: UserProfileDTO?, _ error: String?) -> Void)
    
    func getUserByNickName(nick: String, completion: @escaping (_ response: UserProfileDTO?, _ error: String?) -> Void)
    
    func getUserInfo(id: Int, completion: @escaping (_ response: UserDTO?, _ error: String?) -> Void)
    
    func whoAmI(completion: @escaping (_ response: UserDTO?, _ error: String?) -> Void)
    
    func signOut(completion: @escaping (_ response: String?, _ error: String?) -> Void)
    
    func getFriends(id: Int, completion: @escaping (_ response: FriendsResponseDTO?, _ error: String?) -> Void)
    
    func getClubs(id: Int, completion: @escaping (_ response: ClubsResponseDTO?, _ error: String?) -> Void)
    
    func getAnimeRates(id: Int, page: Int?, limit: Int?, status: UserContentState?, isCensored: Bool?, completion: @escaping (_ response: AnimeRatesResponseDTO?, _ error: String?) -> Void)
    
    func getMangaRates(id: Int, page: Int?, limit: Int?, status: UserContentState?, isCensored: Bool?, completion: @escaping (_ response: MangaRatesResponseDTO?, _ error: String?) -> Void)
    
    func getFavorites(id: Int, completion: @escaping (_ response: UserFavoritesResponseDTO?, _ error: String?) -> Void)
    
    func getHistory(
        id: Int,
        page: Int?,
        limit: Int?,
        targetId: Int?,
        type: TargetType?,
        completion: @escaping (_ response: UserHistoryResponseDTO?, _ error: String?) -> Void
    )
    
    func getBans(id: Int, completion: @escaping (_ response: BansResponseDTO?, _ error: String?) -> Void)
    
}

// MARK: - UsersRequestFactoryProtocol extension

extension UsersRequestFactoryProtocol {

    // MARK: - Functions

    func getUsers(page: Int?,
                  limit: Int?,
                  completion: @escaping (_ response: UsersResponseDTO?, _ error: String?) -> Void) {
        let parameters = validateParameters(page: page, limit: limit)
        delegate?.getResponse(
            type: UsersResponseDTO.self,
            endPoint: .listUsers(parameters: parameters),
            completion: completion
        )
        return

        func validateParameters(page: Int?, limit: Int?) -> Parameters {
            var parameters = Parameters()
            if let page = page,
               (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
                parameters[APIKeys.page.rawValue] = page
            }
            if let limit = limit,
               (1 ... APIRestrictions.limit100.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
            }
            return parameters
        }
    }

    func getUserById(id: Int, completion: @escaping (_ response: UserProfileDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: UserProfileDTO.self, endPoint: .getUserById(id: id), completion: completion)
    }

    func getUserByNickName(nick: String, completion: @escaping (_ response: UserProfileDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: UserProfileDTO.self,
            endPoint: .getUserByNickName(nick: nick, parameters: [APIKeys.isNickName.rawValue: 1]),
            completion: completion
        )
    }

    func getUserInfo(id: Int, completion: @escaping (_ response: UserDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: UserDTO.self, endPoint: .getUserInfo(id: id), completion: completion)
    }

    func whoAmI(completion: @escaping (_ response: UserDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: UserDTO.self, endPoint: .whoAmI, completion: completion)
    }

    func signOut(completion: @escaping (_ response: String?, _ error: String?) -> Void) {
        delegate?.getResponse(type: String.self, endPoint: .whoAmI, completion: completion)
    }

    func getFriends(id: Int, completion: @escaping (_ response: FriendsResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: FriendsResponseDTO.self, endPoint: .listFriends(id: id), completion: completion)
    }

    func getClubs(id: Int, completion: @escaping (_ response: ClubsResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: ClubsResponseDTO.self, endPoint: .listClubs(id: id), completion: completion)
    }

    func getAnimeRates(id: Int,
                       page: Int? = nil,
                       limit: Int? = nil,
                       status: UserContentState?,
                       isCensored: Bool?,
                       completion: @escaping (_ response: AnimeRatesResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: AnimeRatesResponseDTO.self,
            endPoint: .listAnimeRates(
                id: id,
                parameters: validateParameters(
                    page: page,
                    limit: limit,
                    status: status,
                    isCensored: isCensored
                )
            ),
            completion: completion
        )
        return

    }

    func getMangaRates(id: Int,
                       page: Int? = nil,
                       limit: Int? = nil,
                       status: UserContentState?,
                       isCensored: Bool?,
                       completion: @escaping (_ response: MangaRatesResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: MangaRatesResponseDTO.self,
            endPoint: .listMangaRates(
                id: id,
                parameters: validateParameters(
                    page: page,
                    limit: limit,
                    status: status,
                    isCensored: isCensored
                )
            ),
            completion: completion
        )
        return

    }

    func getFavorites(id: Int,
                      completion: @escaping (_ response: UserFavoritesResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: UserFavoritesResponseDTO.self,
            endPoint: .listFavorites(id: id),
            completion: completion
        )
    }

    func getMessages(id: Int,
                     page: Int? = nil,
                     limit: Int? = nil,
                     type: UserMessageType,
                     completion: @escaping (_ response: MessagesResponseDTO?, _ error: String?) -> Void) {
        let parameters = validateParameters(page: page, limit: page, type: type)
        delegate?.getResponse(
            type: MessagesResponseDTO.self,
            endPoint: .listMessages(id: id, parameters: parameters),
            completion: completion
        )
        return

        func validateParameters(page: Int?,
                                limit: Int?,
                                type: UserMessageType) -> Parameters {
            var parameters = Parameters()
            if let page = page,
               (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
                parameters[APIKeys.page.rawValue] = page
            }
            if let limit = limit,
               (1 ... APIRestrictions.limit100.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
            }
            parameters[APIKeys.type.rawValue] = type.rawValue
            return parameters
        }
    }

    func getUnreadMessages(id: Int,
                           completion: @escaping (_ response: UnreadMessagesResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: UnreadMessagesResponseDTO.self,
            endPoint: .unreadMessages(id: id),
            completion: completion
        )
    }

    func getHistory(id: Int,
                    page: Int? = nil,
                    limit: Int? = nil,
                    targetId: Int? = nil,
                    type: TargetType?,
                    completion: @escaping (_ response: UserHistoryResponseDTO?, _ error: String?) -> Void) {
        let parameters = validateParameters(page: page, limit: limit, targetId: targetId, type: type)
        delegate?.getResponse(
            type: UserHistoryResponseDTO.self,
            endPoint: .listHistory(id: id, parameters: parameters),
            completion: completion
        )
        return

        func validateParameters(page: Int?, limit: Int?, targetId: Int?, type: TargetType?) -> Parameters {
            var parameters = Parameters()
            if let page = page,
               (1 ... APIRestrictions.maxPages.rawValue).contains(page) { parameters[APIKeys.page.rawValue] = page
            }
            if let limit = limit,
               (1 ... APIRestrictions.limit100.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
            }
            if let targetId = targetId { parameters[APIKeys.targetId.rawValue] = targetId }
            if let type = type { parameters[APIKeys.targetType.rawValue] = type.rawValue }
            return parameters
        }
    }

    func getBans(id: Int, completion: @escaping (_ response: BansResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: BansResponseDTO.self, endPoint: .listBans(id: id), completion: completion)
    }

    // MARK: - Private functions

    private func validateParameters(
                            page: Int?,
                            limit: Int?,
                            status: UserContentState?,
                            isCensored: Bool?
    ) -> Parameters {
        var parameters = Parameters()
        if let page,
           (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
            parameters[APIKeys.page.rawValue] = page
        }
        if let limit,
           (1 ... APIRestrictions.limit5000.rawValue).contains(limit) { parameters[APIKeys.limit.rawValue] = limit
        }
        if let status { parameters[APIKeys.status.rawValue] = status.rawValue }
        if let isCensored { parameters[APIKeys.censored.rawValue] = isCensored }
        return parameters
    }
}

// MARK: - UsersRequestFactory

final class UsersRequestFactory: UsersRequestFactoryProtocol {

    // MARK: - Properties
    
    let delegate: (AbstractRequestFactory<UsersApi>)?

    // MARK: - Construction

    init() {
        delegate = AbstractRequestFactory<UsersApi>()
    }
}
