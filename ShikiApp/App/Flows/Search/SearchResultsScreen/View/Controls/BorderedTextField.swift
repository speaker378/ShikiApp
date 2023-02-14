//
//  BorderedTextField.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 08.02.2023.
//

import UIKit

final class BorderedTextField: UITextField {

    // MARK: - Private properties
    
    private let rightBorder: UIView = {
        let view = UIView.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.line
        return view
    }()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    private func configureUI() {
        keyboardType = .default
        backgroundColor = AppColor.backgroundMinor
        font = AppFont.openSansFont(ofSize: 16, weight: .regular)
        textColor = AppColor.textMain
        placeholder = ControlConstants.searchPlaceHolder
        borderStyle = .none
        addSubview(rightBorder)
        textAlignment = .left
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            rightBorder.leftAnchor.constraint(equalTo: rightAnchor, constant: -1),
            rightBorder.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightBorder.rightAnchor.constraint(equalTo: rightAnchor),
            rightBorder.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.45)
        ])
    }

}
