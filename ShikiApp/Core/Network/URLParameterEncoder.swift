//
//  URLParameterEncoder.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - URLParameterEncoder

struct URLParameterEncoder: ParameterEncoder {

    // MARK: - ParameterEncoder protocol implementation
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {

        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: HttpConstants.contentType) == nil {
            urlRequest.setValue(
                HttpConstants.formUrlEncodedContent,
                forHTTPHeaderField: HttpConstants.contentType
            )
        }
    }
}
