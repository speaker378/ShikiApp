//
//  OAuth2Request.swift
//  ShikiApp
//
//  Created by Сергей Черных on 08.02.2023.
//

import Foundation

struct OAuth2Request {
    
    let authUrl: String
    let tokenUrl: String
    let clientId: String
    let redirectUri: String
    let clientSecret: String
    let scopes: [String]
}

extension OAuth2Request {
    
    func makeAuthURL() -> URL? {
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: scopes.joined(separator: "+"))
        ]
        var components = URLComponents(string: authUrl)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func makeTokenURL(code: String) -> URL? {
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "redirect_uri", value: redirectUri)
        ]
        var components = URLComponents(string: tokenUrl)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func makeRefreshTokenURL(refreshToken: String) -> URL? {
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "refresh_token", value: refreshToken),
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "redirect_uri", value: redirectUri)
        ]
        var components = URLComponents(string: tokenUrl)
        components?.queryItems = queryItems
        return components?.url
    }
}
