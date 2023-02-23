//
//  ChipsTableViewCell.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 16.02.2023.
//

import UIKit

final class ChipsTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private let verticalInset = 2.0
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = Constants.Spacing.small
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Functions
    
    func configure(content: [String]) {
        addSubview(stackView)
        configureConstraints()
        content.forEach { value in
            let chipsView = ChipsView(title: value, style: .gray)
            stackView.addArrangedSubview(chipsView)
        }
    }

    // MARK: - Private functions
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: verticalInset),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalInset)
        ])
    }
}
