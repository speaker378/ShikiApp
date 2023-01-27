//
//  HttpConstants.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 27.01.2023.
//

import Foundation
enum HttpConstants: String {

    case contentType = "Content-Type"
    case formEncodedContent = "application/x-www-form-urlencoded; charset=utf-8"
    case jsonContent = "application/json"
    case bearer = "Bearer"
    case authorization = "Authorization"
    case agent = "User-Agent"
}
