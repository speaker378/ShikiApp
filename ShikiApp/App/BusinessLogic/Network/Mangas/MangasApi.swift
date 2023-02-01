//
//  MangasApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 31.01.2023.
//

import Foundation

// MARK: - MangasApi

enum MangasApi {
    case list(parameters: Parameters)
    case getById(id: Int)
}

// MARK: MangasApi EndPointType extension

extension MangasApi: EndPointType {
    
    var path: String {
        switch self {
        case .list:
            return "mangas"
        case let .getById(id):
            return "mangas/\(id)"
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
