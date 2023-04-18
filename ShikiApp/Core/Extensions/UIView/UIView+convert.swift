//
//  UIView+convert.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.03.2023.
//

import UIKit

extension UIView {
    
    func convert(_ frame: CGRect, toView view: UIView) -> CGRect {
        let convertedOrigin = convert(frame.origin, from: view)
        return CGRect(origin: convertedOrigin, size: frame.size)
    }
}
