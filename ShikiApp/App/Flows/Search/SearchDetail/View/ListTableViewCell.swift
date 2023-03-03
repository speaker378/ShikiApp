//
//  ListTableViewCell.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 02.03.2023.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private let label: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.regularText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Functions
    
    func configure(content: String) {
        addSubview(label)
        backgroundColor = AppColor.backgroundMain
        label.text = content
        label.textColor = content == Texts.ButtonTitles.removeFromList ? AppColor.red : AppColor.textMain
        configureConstraints()
    }

    // MARK: - Private functions
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constants.Insets.sideInset)
        ])
    }
}
