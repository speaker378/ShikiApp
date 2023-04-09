//
//  UserRatesManagerProtocol.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 08.04.2023.
//

protocol UserRatesManagerProtocol {
//    associatedtype ContentKind: Codable

    // MARK: - Functions
    
    func createUserRate(userRate: UserRatesModel)
    func updateUserRate(userRate: UserRatesModel)
    func removeUserRate(userRateID: Int)
} 
