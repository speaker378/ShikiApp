//
//  UserDefaultsService.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 09.03.2023.
//

import Foundation

// MARK: - UserDefaultsService

final class UserDefaultsService {

    // MARK: - Private properties

    private let defaults = UserDefaults.standard

    // MARK: - Functions

    func save<T: Codable>(_ value: T?) {
        let json = try? JSONEncoder().encode(value)
        let key = String(describing: T.self)
        defaults.set(json, forKey: key)
    }
    
    func  restore<T: Codable>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        if let json = defaults.value(forKey: key) as? Data {
            return try? JSONDecoder().decode(type, from: json)
        }
        return nil
    }
}
