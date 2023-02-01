//
//  EndPointType.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - EndPointType

protocol EndPointType {
    
    static var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

// MARK: - EndPointType extension

extension EndPointType {
    
    static var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: HttpConstants.apiUrl) as? String,
              let url = URL(string: urlString)
        else {
            fatalError(HttpConstants.urlError)
        }
        return url
    }
}
