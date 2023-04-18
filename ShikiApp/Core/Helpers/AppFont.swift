//
//  AppFont.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
// Класс для создания UIFont
// Пример использования:
// let label.font = AppFont.openSansFont(ofSize: 16, weight: .regular)

import UIKit

struct AppFont {
    
    // Family: Open Sans For names: ["OpenSans-Regular", "OpenSans-SemiBold", "OpenSans-Bold", "OpenSans-ExtraBold"]
    enum OpenSans: String {
        case regular = "-Regular"
        case semiBold = "-SemiBold"
        case bold = "-Bold"
        case extraBold = "-ExtraBold"
    }
    
    enum Style {
        /// 12, regular
        static let subtitle = AppFont.openSansFont(ofSize: 12)
        /// 16, regular
        static let regularText = AppFont.openSansFont(ofSize: 16)
        /// 16, bold
        static let blockTitle = AppFont.openSansFont(ofSize: 16, weight: .bold)
        /// 20, semiBold
        static let pageTitle = AppFont.openSansFont(ofSize: 20, weight: .semiBold)
        /// 20, bold
        static let title = AppFont.openSansFont(ofSize: 20, weight: .bold)
        /// 28, extraBold
        static let pageLargeTitle = AppFont.openSansFont(ofSize: 28, weight: .extraBold)
    }
    
    static func openSansFont(ofSize size: CGFloat = UIFont.systemFontSize, weight: OpenSans = .regular) -> UIFont {
        return UIFont(name: "OpenSans\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
