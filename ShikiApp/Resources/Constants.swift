//
//  Constants.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
//  класс предназначен для различных констант, используемых по всему приложению

import Foundation

struct Constants {
    
    enum Url {
        static let apiUrl = Bundle.main.object(forInfoDictionaryKey: HttpConstants.apiUrl) as? String ?? ""
        static let baseUrl = Bundle.main.object(forInfoDictionaryKey: HttpConstants.baseUrl) as? String ?? ""
    }
    
    enum Keys {
        
    }
    
    enum DateFormatter {
        static let dayMonthCommaHoursMinutes = "dd MMMM, HH:mm"
    }
}
