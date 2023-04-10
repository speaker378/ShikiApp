//
//  UserRatesManagerProtocol.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 08.04.2023.
//

protocol UserRatesManagerProtocol {
//    associatedtype ContentKind: Codable

    // MARK: - Functions
    
    func createUserRate(userRate: UserRatesModel, errorHandler: @escaping (String) -> Void)
    func updateUserRate(userRate: UserRatesModel, errorHandler: @escaping (String) -> Void)
    func removeUserRate(userRateID: Int, errorHandler: @escaping (String) -> Void)
} 
