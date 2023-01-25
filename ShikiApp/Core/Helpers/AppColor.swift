//
//  AppColor.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//

import UIKit

enum AppColor {

    private static let missingColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

    static let line = UIColor(named: "line") ?? missingColor
    static let textInvert = UIColor(named: "textInvert") ?? missingColor
    static let textMain = UIColor(named: "textMain") ?? missingColor
    static let textMinor = UIColor(named: "textMinor") ?? missingColor
    static let accent = UIColor(named: "accent") ?? missingColor
    static let coverGradient1 = UIColor(named: "coverGradient1") ?? missingColor
    static let coverGradient2 = UIColor(named: "coverGradient2") ?? missingColor
    static let backgroundMain = UIColor(named: "backgroundMain") ?? missingColor
    static let backrgoundMinor = UIColor(named: "backrgoundMinor") ?? missingColor
    
}
