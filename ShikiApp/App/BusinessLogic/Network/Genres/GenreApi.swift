//
//  GenreApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.02.2023.
//

import Foundation

// MARK: - GenreApi

enum GenreApi {
    case list
}

// MARK: GenreApi EndPointType extension

extension GenreApi: EndPointType {

    // MARK: Properties

    var path: String {
            return "genres"
    }
    var httpMethod: HTTPMethod { .get }
    var task: HTTPTask {
        switch self {
        case .list:
            return .request
        }
    }
    var headers: HTTPHeaders? { nil }
}
