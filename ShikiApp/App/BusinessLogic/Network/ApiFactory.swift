//
//  ApiFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

// MARK: - ApiFactoryProtocol

protocol ApiFactoryProtocol {
    
    static func makeForumsApi() -> ForumsRequestFactoryProtocol
    static func makeTopicsApi() -> TopicsRequestFactoryProtocol
    static func makeAnonimousTopicsApi() -> TopicsRequestFactoryProtocol
}

// MARK: - ApiFactory

final class ApiFactory: ApiFactoryProtocol {

    // MARK: - Private properties

    private static var token: String? {
        guard let token = ProcessInfo.processInfo.environment["TOKEN"] else { return nil }
        return token
    }

    private static var agent: String? {
        guard let agent = ProcessInfo.processInfo.environment["USER_AGENT"] else { return nil }
        return agent
    }

    // MARK: - ApiFactoryProtocol implementation

    static func makeForumsApi() -> ForumsRequestFactoryProtocol {
        ForumsRequestFactory(agent: agent)
    }

    static func makeTopicsApi() -> TopicsRequestFactoryProtocol {
        TopicsRequestFactory(token: token, agent: agent)
    }

    static func makeAnonimousTopicsApi() -> TopicsRequestFactoryProtocol {
        TopicsRequestFactory(agent: agent)
    }

    static func makeUsersApi() -> UsersRequestFactory {
        UsersRequestFactory(token: token, agent: agent)
    }
}
