//
//  UIView+setShadow.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 13.02.2023.
//

import UIKit

extension UIView {
    func setShadow(shadowColor: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat, masksToBounds: Bool ) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = masksToBounds
    }
}
