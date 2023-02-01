//
//  UsersApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

enum UsersApi {
    case whoAmI
    case listUsers(parameters: Parameters)
    case getUserById(id: Int)
    case getUserInfo(id: Int)
    case getUserByNickName(nick: String, parameters: Parameters)
    case signOut
    case listFriends(id: Int)
    case listClubs(id: Int)
    case listFavorites(id: Int)
    case listAnimeRates(id: Int, parameters: Parameters)
    case listMangaRates(id: Int, parameters: Parameters)
    case listMessages(id: Int, parameters: Parameters)
    case unreadMessages(id: Int)
    case listHistory(id: Int, parameters: Parameters)
    case listBans(id: Int)
}

extension UsersApi: EndPointType {
    
    var path: String {
        switch self {
        case .listUsers:
            return "users"
        case .getUserById(let id):
            return "users/\(id)"
        case .getUserInfo(let id):
            return "users/\(id)/info"
        case .getUserByNickName(let nick, _):
            return "users/\(nick)"
        case .whoAmI:
            return "users/whoami"
        case .signOut:
            return "users/sign_out"
        case .listFriends(let id):
            return "users/\(id)/friends"
        case .listClubs(let id):
            return "users/\(id)/clubs"
        case .listFavorites(let id):
            return "users/\(id)/favourites"
        case .listAnimeRates(let id, _):
            return "users/\(id)/anime_rates"
        case .listMangaRates(let id, _):
            return "users/\(id)/manga_rates"
        case .listMessages(let id, _):
            return "users/\(id)/messages"
        case .unreadMessages(let id):
            return "users/\(id)/unread_messages"
        case .listHistory(let id, _):
            return "users/\(id)/history"
        case .listBans(let id):
            return "users/\(id)/bans"
        }
    }

    var httpMethod: HTTPMethod { .get }

    var task: HTTPTask {
        switch self {
        case .listUsers(let parameters),
             .listAnimeRates(_, let parameters),
             .listMangaRates(_, let parameters),
             .listMessages(_, let parameters),
             .listHistory(_, let parameters),
             .getUserByNickName(_, let parameters):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameters)
        case .getUserById,
             .whoAmI,
             .signOut,
             .listFriends,
             .listClubs,
             .listBans,
             .listFavorites,
             .unreadMessages,
             .getUserInfo:
            return .request
        }
    }

    var headers: HTTPHeaders? { nil }
}
