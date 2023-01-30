//
//  UIView+addSubviews.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//

// Класс для быстрого добавления View
// Пример использования
// myView.addSubviews([view1, view2])

import UIKit

extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview)
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
