//
//  ControlConstants.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 07.02.2023.
//


import UIKit

struct ControlConstants {
    
    static let sliderImage: UIImage = {
        UIImage(systemName: "slider.horizontal.3") ?? UIImage()}()
    static let searchPlaceHolder = "Аниме, манга, ранобэ"

    enum Header {
        static let emptyResult = ""
        static let emptyStringResult = "Лучшие"
        static let exactResult = "Найдено:"
        static let approximateResult = "Результаты поиска"
    }
    enum Properties {
        static let cellHeight: CGFloat = 112
        static let tableHeaderHeight: CGFloat = 27
        static let resultsLabelVerticalOffset: CGFloat = 22
        static let searchRadius: CGFloat = 16
        static let tableTop: CGFloat = 234
        static let inputVerticalOffset: CGFloat = 13
        static let inputRightInset: CGFloat = 50
        static let searchTop: CGFloat = 22
        static let searchHeight: CGFloat = 48
        static let topInset: CGFloat = 8
        static let segmentTop: CGFloat = 71
        static let segmentHeight: CGFloat = 28
        static let segmentRadius: CGFloat = 8.91
        static let backgroundImageSize: CGFloat  = 105
        static let backgroundLabelInset: CGFloat  = 24
    }
}
