//
//  NetworkErrorMessages.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 25.01.2023.
//

import Foundation

enum NetworkLayerErrorMessages: String {
    case success = "Success"
    case authenticationError = "You need to be authenticated."
    case badRequest = "Bad request"
    case outdated = "The url is outdated."
    case requestFailed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response"
    case badResponse = "Bad response"
}
