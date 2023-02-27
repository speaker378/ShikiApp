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

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview)
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
