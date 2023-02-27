//
//  UserRatesApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 24.02.2023.
//

import Foundation

// MARK: - UserRatesApi

enum UserRatesApi {
    case getList(parameters: Parameters)
    case getById(id: Int)
    case postUserRates(parameters: Parameters)
    case putUserRates(id: Int, parameters: Parameters)
    case postIncrement(id: Int)
    case deleteUserRates(id: Int)
}

// MARK: EndPointType

extension UserRatesApi: EndPointType {
    var path: String {
        switch self {
        case .getList,
             .postUserRates:
            return "v2/user_rates"
        case .deleteUserRates(let id),
             .getById(let id),
             .putUserRates(let id, _):
            return "v2/user_rates/\(id)"
        case .postIncrement(let id):
            return "v2/user_rates/\(id)/increment"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getById,
             .getList:
            return .get
        case .postIncrement,
             .postUserRates:
            return .post
        case .putUserRates:
            return .put
        case .deleteUserRates:
            return .delete
        }}

    var task: HTTPTask {
        switch self {
        case .getList(let parameters):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameters)
        case .postUserRates(let parameters),
             .putUserRates(_, let parameters):
            return .requestParameters(bodyParameters: parameters, bodyEncoding: .jsonEncoding, urlParameters: nil)
        case .getById,
             .postIncrement,
             .deleteUserRates:
            return .request
        }
    }

    var headers: HTTPHeaders? { nil }
}
