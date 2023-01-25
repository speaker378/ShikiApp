//
//  NetworkResponse.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 25.01.2023.
//

import Foundation

// MARK: - NetworkResponse

enum NetworkResponse {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case badResponse
}

// MARK: - NetworkResponse extended by rawValue property

extension NetworkResponse {
    var rawValue: String {
        switch self {
        case .success:
            return NetworkLayerErrorMessages.success.rawValue
        case .authenticationError:
            return NetworkLayerErrorMessages.authenticationError.rawValue
        case .badRequest:
            return NetworkLayerErrorMessages.badRequest.rawValue
        case .outdated:
            return NetworkLayerErrorMessages.outdated.rawValue
        case .failed:
            return NetworkLayerErrorMessages.requestFailed.rawValue
        case .noData:
            return NetworkLayerErrorMessages.noData.rawValue
        case .unableToDecode:
            return NetworkLayerErrorMessages.unableToDecode.rawValue
        case .badResponse:
            return NetworkLayerErrorMessages.badResponse.rawValue
        }
    }
}
