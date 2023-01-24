//
//  String+.swift
//  ShikiApp
//
//  Created by Сергей Черных on 24.01.2023.
//

import UIKit

extension String {
    func getTextHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let textBlock = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: textBlock,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        
        let height = Double(rect.size.height)
        return CGFloat(height).rounded(.up)
    }
}
