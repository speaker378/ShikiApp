//
//  AuthParameters.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation
final class AuthParameters {
    public static let shared = AuthParameters()
    var token: String
    var userAgent: String
    private init() {
        self.token = "BrNsXGRgVpu_w3TVM8C1LgCbJTuYYZbffZh2TMng8vw"
        self.userAgent = "Shiki-ios"
    }
    
}
