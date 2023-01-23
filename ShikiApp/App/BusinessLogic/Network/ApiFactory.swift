//
//  ApiFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

final class ApiFactory {
    // MARK: - Private properties

    private static var token: String? {
        guard let token = ProcessInfo.processInfo.environment["TOKEN"] else { return nil }
        return token
    }

    private static var agent: String? {
        guard let agent = ProcessInfo.processInfo.environment["USER_AGENT"] else { return nil }
        return agent
    }

    // MARK: - API makers interface

    static func makeForumsApi() -> ForumsRequestFactory { ForumsRequestFactory(agent: agent) }

    static func makeTopicsApi() -> TopicsRequestFactory { TopicsRequestFactory(token: token, agent: agent) }

    static func makeAnonimousTopicsApi() -> TopicsRequestFactory { TopicsRequestFactory(agent: agent) }

    static func makeUsersApi() -> UsersRequestFactory { UsersRequestFactory(token: token, agent: agent) }
}
