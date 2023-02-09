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
        static let baseYoutubeUrl = "https://www.youtube.com/embed/"
        static let deeplinkYoutubeUrl = "http://www.youtube.com/watch?v="
    }
    
    enum Keys {
        
    }
    
    enum Insets {
        /// отступ по краям экрана, можно использовать и сверху, снизу
        static let sideInset: CGFloat = 16.0
        /// высота у кнопок, полей
        static let controlHeight: CGFloat = 48.0
        /// высота обложки у ячеек
        static let coverHeight: CGFloat = 112.0
        /// ширина обложки у ячеек
        static let coverWidth: CGFloat = 88.0
        static let iconSmallHeight: CGFloat = 24.0
        static let iconMediumHeight: CGFloat = 32.0
    }
    
    enum Spacing {
        static let medium: CGFloat = 8.0
        static let small: CGFloat = 4.0
    }
    
    enum CornerRadius {
        static let medium: CGFloat = 16.0
        static let small: CGFloat = 8.0
        static let xSmall: CGFloat = 4.0
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
