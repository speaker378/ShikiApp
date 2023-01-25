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
            return NetworkLayerErrorMessages.success
        case .authenticationError:
            return NetworkLayerErrorMessages.authenticationError
        case .badRequest:
            return NetworkLayerErrorMessages.badRequest
        case .outdated:
            return NetworkLayerErrorMessages.outdated
        case .failed:
            return NetworkLayerErrorMessages.requestFailed
        case .noData:
            return NetworkLayerErrorMessages.noData
        case .unableToDecode:
            return NetworkLayerErrorMessages.unableToDecode
        case .badResponse:
            return NetworkLayerErrorMessages.badResponse
        }
    }
}
