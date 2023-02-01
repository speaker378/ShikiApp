//
//  RanobeApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 01.02.2023.
//

import Foundation

// MARK: - RanobesApi

enum RanobeApi {
    case list(parameters: Parameters)
    case getById(id: Int)
}

// MARK: RanobesApi EndPointType extension

extension RanobeApi: EndPointType {
    var path: String {
        switch self {
        case .list:
            return "ranobe"
        case let .getById(id):
            return "ranobe/\(id)"
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
