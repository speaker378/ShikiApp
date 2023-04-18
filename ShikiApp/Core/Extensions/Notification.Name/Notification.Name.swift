//
//  Notification.Name.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 15.03.2023.
//

import Foundation

extension Notification.Name {

    static var credentialsChanged: Notification.Name {
        return .init(rawValue: "Credentials.changed")
    }
}
