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
    
    enum Prefix {
        static let byte = 1
        static let kilobyte = 1024
        static let megabyte = 1048576
    }
    
    enum ImageCacheParam {
        static let memoryCapacity = 50 * Prefix.megabyte
        static let diskCapacity = 50 * Prefix.megabyte
        static let maximumConnections = 5
    }
}
