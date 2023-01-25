//
//  ForumsRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
// FF

import Foundation

// MARK: - ForumsRequestFactoryProtocol

protocol ForumsRequestFactoryProtocol {
    
    func listForums(completion: @escaping (_ response: ForumsResponseDTO?, _ error: String?) -> Void)
}

// MARK: - ForumsRequestFactory

final class ForumsRequestFactory: AbstractRequestFactory<ForumsApi> {}

// MARK: ForumsRequestFactory extension to ForumsRequestFactoryProtocol

extension ForumsRequestFactory: ForumsRequestFactoryProtocol {
    
    func listForums(completion: @escaping (_ response: ForumsResponseDTO?, _ error: String?) -> Void) { getResponse(type: ForumsResponseDTO.self, endPoint: .list, completion: completion) }
}
