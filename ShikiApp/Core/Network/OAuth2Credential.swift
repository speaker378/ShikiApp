//
//  OAuth2Credential.swift
//  ShikiApp
//
//  Created by Сергей Черных on 08.02.2023.
//

import Foundation

struct OAuth2Credential: Codable {
    
    let accessToken: String
    let tokenType: String?
    let refreshToken: String?
    let scope: String?
    let expiresIn: Int?
    var expire: Date?
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case tokenType
        case refreshToken
        case scope
        case expiresIn
        case expire
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.tokenType = try container.decodeIfPresent(String.self, forKey: .tokenType)
        self.refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
        self.scope = try container.decodeIfPresent(String.self, forKey: .scope)
        self.expiresIn = try container.decodeIfPresent(Int.self, forKey: .expiresIn)
        self.expire = try container.decodeIfPresent(Date.self, forKey: .expire)
        if expire == nil {
            guard let expiresIn else { return }
            self.expire = Date.now.addingTimeInterval(Double(expiresIn))
        }
    }
}
