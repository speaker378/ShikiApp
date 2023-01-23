//
//  UsersRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

final class UsersRequestFactory: AbstractRequestFactory<UsersApi> {
    func getUsers(page: Int?, limit: Int?, completion: @escaping (_ response: UsersResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 100).contains(limit) { parameters["limit"] = limit }
        getResponse(type: UsersResponse.self, endPoint: .listUsers(parameters: parameters), completion: completion)
    }
    
    func getUserById(id: Int, completion: @escaping (_ response: UserProfile?, _ error: String?) -> Void) {
        getResponse(type: UserProfile.self, endPoint: .getUserById(id: id), completion: completion)
    }
    
    func getUserByNickName(nick: String, completion: @escaping (_ response: UserProfile?, _ error: String?) -> Void) {
        getResponse(type: UserProfile.self, endPoint: .getUserByNickName(nick: nick, parameters: ["is_nickname": 1]), completion: completion)
    }
    
    func getUserInfo(id: Int, completion: @escaping (_ response: User?, _ error: String?) -> Void) {
        getResponse(type: User.self, endPoint: .getUserInfo(id: id), completion: completion)
    }
    
    func whoAmI(completion: @escaping (_ response: User?, _ error: String?) -> Void) {
        getResponse(type: User.self, endPoint: .whoAmI, completion: completion)
    }
    
    func signOut(completion: @escaping (_ response: String?, _ error: String?) -> Void) {
        getResponse(type: String.self, endPoint: .whoAmI, completion: completion)
    }
    
    func getFriends(id: Int, completion: @escaping (_ response: FriendsResponse?, _ error: String?) -> Void) {
        getResponse(type: FriendsResponse.self, endPoint: .listFriends(id: id), completion: completion)
    }
    
    func getClubs(id: Int, completion: @escaping (_ response: ClubsResponse?, _ error: String?) -> Void) {
        getResponse(type: ClubsResponse.self, endPoint: .listClubs(id: id), completion: completion)
    }
    
    func getAnimeRates(id: Int, page: Int? = nil, limit: Int? = nil, status: UserContentState?, isCensored: Bool?, completion: @escaping (_ response: AnimeRatesResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 5000).contains(limit) { parameters["limit"] = limit }
        if let status = status { parameters["status"] = status.rawValue }
        if let isCensored = isCensored { parameters["censored"] = isCensored }
        getResponse(type: AnimeRatesResponse.self, endPoint: .listAnimeRates(id: id, parameters: parameters), completion: completion)
    }
    
    func getMangaRates(id: Int, page: Int? = nil, limit: Int? = nil, isCensored: Bool?, completion: @escaping (_ response: MangaRatesResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 5000).contains(limit) { parameters["limit"] = limit }
        if let isCensored = isCensored { parameters["censored"] = isCensored }
        getResponse(type: MangaRatesResponse.self, endPoint: .listMangaRates(id: id, parameters: parameters), completion: completion)
    }
    
    func getFavorites(id: Int, completion: @escaping (_ response: UserFavoritesResponse?, _ error: String?) -> Void) {
        getResponse(type: UserFavoritesResponse.self, endPoint: .listFavorites(id: id), completion: completion)
    }
    
    func getMessages(id: Int, page: Int? = nil, limit: Int? = nil, type: UserMessageType, completion: @escaping (_ response: UserFavoritesResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 100).contains(limit) { parameters["limit"] = limit }
        parameters["type"] = type.rawValue
        getResponse(type: UserFavoritesResponse.self, endPoint: .listMessages(id: id, parameters: parameters), completion: completion)
    }
    
    func getUnreadMessages(id: Int, completion: @escaping (_ response: UnreadMessagesResaponse?, _ error: String?) -> Void) {
        getResponse(type: UnreadMessagesResaponse.self, endPoint: .unreadMessages(id: id), completion: completion)
    }
    
    func getHistory(id: Int, page: Int? = nil, limit: Int? = nil, targetId: Int? = nil,
                    type: TargetType?, completion: @escaping (_ response: UserHistoryResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 100).contains(limit) { parameters["limit"] = limit }
        if let targetId = targetId { parameters["target_id"] = targetId }
        if let type = type { parameters["target_type"] = type.rawValue }
        getResponse(type: UserHistoryResponse.self, endPoint: .listHistory(id: id, parameters: parameters), completion: completion)
    }
    
    func getBans(id: Int, completion: @escaping (_ response: BansResponse?, _ error: String?) -> Void) {
        getResponse(type: BansResponse.self, endPoint: .listBans(id: id), completion: completion)
    }
}
