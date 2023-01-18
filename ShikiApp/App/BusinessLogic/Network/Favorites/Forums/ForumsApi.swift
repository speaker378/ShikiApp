//
//  ForumsApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

public enum ForumsApi {
    case list
}

extension ForumsApi: EndPointType {
    var path: String { "forums" }

    var httpMethod: HTTPMethod { .get }

    var task: HTTPTask {
        switch self {
        case .list:
            return .request
        }
    }

    var headers: HTTPHeaders? { nil }
}
