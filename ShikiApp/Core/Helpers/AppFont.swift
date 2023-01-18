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
    
    static func openSansFont(ofSize size: CGFloat = UIFont.systemFontSize, weight: OpenSans = .regular) -> UIFont {
        return UIFont(name: "OpenSans\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
    
}
