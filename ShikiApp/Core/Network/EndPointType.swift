//
//  EndPointType.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - EndPointType protocol

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
        guard let url = URL(string: Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String ?? "") else {
            fatalError("API Base URL could not be configured")
        }
        return url
    }
}
