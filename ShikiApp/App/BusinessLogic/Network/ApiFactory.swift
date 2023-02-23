//
//  ApiFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 20.01.2023.
//

import Foundation

// MARK: - ApiFactoryProtocol

protocol ApiFactoryProtocol {
    
    static func makeGenresApi() -> GenresRequestFactoryProtocol
    static func makeForumsApi() -> ForumsRequestFactoryProtocol
    static func makeTopicsApi() -> TopicsRequestFactoryProtocol
    static func makeAnimesApi() -> AnimesRequestFactoryProtocol
    static func makeMangasApi() -> MangasRequestFactoryProtocol
    static func makeRanobeApi() -> RanobeRequestFactoryProtocol
}

// MARK: - ApiFactory

final class ApiFactory: ApiFactoryProtocol {

    // MARK: - ApiFactoryProtocol implementation

    static func makeGenresApi() -> GenresRequestFactoryProtocol {
        GenresRequestFactory()
    }
    
    static func makeMangasApi() -> MangasRequestFactoryProtocol {
        MangasRequestFactory()
    }
    
    static func makeRanobeApi() -> RanobeRequestFactoryProtocol {
        RanobeRequestFactory()
    }
    
    static func makeAnimesApi() -> AnimesRequestFactoryProtocol {
        AnimesRequestFactory()
    }
    
    static func makeForumsApi() -> ForumsRequestFactoryProtocol {
        ForumsRequestFactory()
    }

    static func makeTopicsApi() -> TopicsRequestFactoryProtocol {
        TopicsRequestFactory()
    }

    static func makeUsersApi() -> UsersRequestFactoryProtocol {
        UsersRequestFactory()
    }

}
