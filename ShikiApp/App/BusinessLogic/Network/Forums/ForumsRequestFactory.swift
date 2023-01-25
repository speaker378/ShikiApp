//
//  ForumsRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
// FF

import Foundation

// MARK: - ForumsRequestFactoryProtocol

protocol ForumsRequestFactoryProtocol {
    
    var delegate: (AbstractRequestFactory<ForumsApi>)? { get }
    
    func listForums(completion: @escaping (_ response: ForumsResponseDTO?, _ error: String?) -> Void)
}

// MARK: - ForumsRequestFactory

final class ForumsRequestFactory: ForumsRequestFactoryProtocol {
    internal let delegate: (AbstractRequestFactory<ForumsApi>)?
    
    init(token: String? = nil, agent: String? = nil) {
        self.delegate = AbstractRequestFactory<ForumsApi>(token: token, agent: agent)
    }
    
}

// MARK: ForumsRequestFactory extension to ForumsRequestFactoryProtocol

extension ForumsRequestFactoryProtocol {
    
    func listForums(completion: @escaping (_ response: ForumsResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: ForumsResponseDTO.self, endPoint: .list, completion: completion)
    }
}
