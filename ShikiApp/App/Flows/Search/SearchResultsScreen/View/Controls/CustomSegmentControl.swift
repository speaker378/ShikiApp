//
//  CustomSegmentControl.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 06.02.2023.
//

import UIKit

class CustomSegmentControl: UISegmentedControl {

    // MARK: - Construction
    
    init(items: [String]) {
        super.init(items: items)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        for item in subviews.enumerated() {
            let opacity: Float = item.offset == selectedSegmentIndex ? 1.0 : 0.0
            item.element.layer.shadowOpacity = opacity
        }
    }

    // MARK: - Private functions
    
    private func configureUI() {
        for view in subviews {
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 6.93).cgPath
            view.layer.shadowColor = AppColor.textMain.cgColor
            view.layer.shadowOpacity = 0
            view.layer.shadowRadius = 8
            view.layer.shadowOffset = CGSize(width: 0, height: 3)
        }
        backgroundColor = AppColor.backgroundMinor
        selectedSegmentTintColor = AppColor.backgroundMain
        setTitleTextAttributes([
            .font: AppFont.openSansFont(ofSize: 13, weight: .regular),
            .foregroundColor: AppColor.textMain
            ], for: .normal)
        setTitleTextAttributes([
            .font: AppFont.openSansFont(ofSize: 13, weight: .semiBold),
            .foregroundColor: AppColor.textMain
            ], for: .selected)
        layer.cornerRadius = ControlConstants.Properties.segmentRadius
        layer.masksToBounds = true
        clipsToBounds = true 
    }
}
