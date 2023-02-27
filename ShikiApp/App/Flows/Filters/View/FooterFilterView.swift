//
//  FooterFilterView.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 13.02.2023.
//

import UIKit

protocol FooterFilterViewDelegate: AnyObject {
    func tapResetAllButton()
    func tapApplyButton()
}

final class FooterFilterView: UIView {

    // MARK: - Properties

    weak var delegate: FooterFilterViewDelegate?

    // MARK: - Private properties

    private let buttonsWidth: CGFloat = UIScreen.main.bounds.width / 2 - Constants.Insets.sideInset - 5

    private(set) lazy var resetAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.backgroundMinor
        button.tintColor = AppColor.textMain
        button.setTitle(Texts.FilterButtons.resetAll, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.CornerRadius.medium
        button.titleLabel?.font = AppFont.Style.blockTitle
        button.addTarget(self, action: #selector(resetAllButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  AppColor.accent
        button.tintColor = AppColor.textInvert
        button.setTitle(Texts.FilterButtons.apply, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.CornerRadius.medium
        button.titleLabel?.font = AppFont.Style.blockTitle
        button.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
        
        return button
    }()

    // MARK: - Construction

    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions

    private func configureUI() {
        backgroundColor = AppColor.backgroundMain
        roundCorners([.topLeft, .topRight], radius: Constants.CornerRadius.medium)
        [
            resetAllButton,
            applyButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureConstraints()
        setShadow(
            shadowColor: AppColor.shadowColor,
            shadowOpacity: 1,
            shadowOffset: CGSize(width: 0, height: -4),
            shadowRadius: 20,
            masksToBounds: false
        )
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            resetAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            resetAllButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Insets.sideInset),
            resetAllButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Insets.sideInset),
            resetAllButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeightLarge),
            resetAllButton.widthAnchor.constraint(equalToConstant: buttonsWidth),
            
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            applyButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Insets.sideInset),
            applyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Insets.sideInset),
            applyButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeightLarge),
            applyButton.widthAnchor.constraint(equalToConstant: buttonsWidth)
        ])
    }
    
    @objc func resetAllButtonPressed() {
        delegate?.tapResetAllButton()
    }
    
    @objc func applyButtonPressed() {
        delegate?.tapApplyButton()
    }
}
