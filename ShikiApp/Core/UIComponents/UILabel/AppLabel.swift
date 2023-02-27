//
//  AppLabel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//

// Класс для создания UILabel
// Пример использования:
// let label = AppLabel(title: "какой-то текст" // (По умолчанию ""),
//                      alignment: .left,
//                      fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
//                      fontСolor: AppColor.textMain, // (По умолчанию AppColor.textMain)
//                      numberLines: 1) // (По умолчанию 1)

import UIKit

   final class AppLabel: UILabel {

    // MARK: - Properties
    
    var title: String?
    var fontСolor: UIColor?
    var numberLines: Int

    // MARK: - Init
    
    init(title: String? = "",
         alignment: NSTextAlignment,
         fontSize: UIFont,
         fontСolor: UIColor? = AppColor.textMain,
         numberLines: Int = 1,
         paddingLeft: CGFloat = 0,
         paddingRight: CGFloat = 0,
         paddingTop: CGFloat = 0,
         paddingBottom: CGFloat = 0) {
        self.title = title
        self.fontСolor = fontСolor
        self.numberLines = numberLines
        super.init(frame: .zero)
        text = title
        font = fontSize
        textAlignment = alignment
        textColor = fontСolor
        numberOfLines = numberLines
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        // MARK: - Padding

        var textEdgeInsets = UIEdgeInsets.zero {
              didSet { invalidateIntrinsicContentSize() }
          }
          
         override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
              let insetRect = bounds.inset(by: textEdgeInsets)
              let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
              let invertedInsets = UIEdgeInsets(
                top: -textEdgeInsets.top,
                left: -textEdgeInsets.left,
                bottom: -textEdgeInsets.bottom,
                right: -textEdgeInsets.right
              )
              return textRect.inset(by: invertedInsets)
          }
          
          override func drawText(in rect: CGRect) {
              super.drawText(in: rect.inset(by: textEdgeInsets))
          }
          
          var paddingLeft: CGFloat {
              get { return textEdgeInsets.left }
              set { textEdgeInsets.left = newValue }
          }

          var paddingRight: CGFloat {
              get { return textEdgeInsets.right }
              set { textEdgeInsets.right = newValue }
          }
          
          var paddingTop: CGFloat {
              get { return textEdgeInsets.top }
              set { textEdgeInsets.top = newValue }
          }
          
          var paddingBottom: CGFloat {
              get { return textEdgeInsets.bottom }
              set { textEdgeInsets.bottom = newValue }
          }
}
