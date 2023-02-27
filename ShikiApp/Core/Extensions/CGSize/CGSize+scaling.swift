//
//  CGSize+scaling.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 10.02.2023.
//

import CoreGraphics

extension CGSize {
    
    func scaleToSize(_ size: CGSize) -> CGSize {
        let widthRatio = size.width / self.width
        let heightRatio = size.height / self.height
        
        let newSize = widthRatio > heightRatio
        ? CGSize(width: self.width * heightRatio, height: self.height * heightRatio)
        : CGSize(width: self.width * widthRatio, height: self.height * widthRatio)
        return newSize
    }
}
