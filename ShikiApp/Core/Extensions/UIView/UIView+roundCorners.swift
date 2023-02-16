//
//  UIView+roundCorners.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 13.02.2023.
//

import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
