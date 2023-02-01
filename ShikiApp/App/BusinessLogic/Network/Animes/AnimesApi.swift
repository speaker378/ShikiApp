//
//  AnimesApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 30.01.2023.
//

import Foundation

// MARK: - AnimesApi

enum AnimesApi {
    case list(parameters: Parameters)
    case getById(id: Int)
}

// MARK: AnimesApi EndPointType extension

extension AnimesApi: EndPointType {
    var path: String {
        switch self {
        case .list:
            return "animes"
        case let .getById(id):
            return "animes/\(id)"
        }
    }

    var httpMethod: HTTPMethod { .get }

    var task: HTTPTask {
        switch self {
        case .list(let parameters):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameters)
        case .getById:
            return .request
        }
    }

    var headers: HTTPHeaders? { nil }
}
