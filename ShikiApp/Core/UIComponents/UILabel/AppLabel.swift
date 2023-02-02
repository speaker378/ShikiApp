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
         numberLines: Int = 1) {
        self.title = title
        self.fontСolor = fontСolor
        self.numberLines = numberLines
        super.init(frame: .zero)
        text = title
        font = fontSize
        textAlignment = alignment
        textColor = fontСolor
        numberOfLines = numberLines
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
