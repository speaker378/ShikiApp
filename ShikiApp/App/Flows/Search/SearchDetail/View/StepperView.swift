//
//  StepperView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 12.03.2023.
//

import UIKit

final class StepperView: UIView {

    // MARK: - Properties

    // MARK: - Private properties
    
    private let stepperWidth: CGFloat = 160.0
    private let titleLabel: AppLabel = {
        let label = AppLabel(title: Texts.DetailLabels.episodes, alignment: .left, fontSize: AppFont.Style.regularText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.title)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let minimumValue = 0
    private let stepperView: UIView = {
        let stepper = UIView()
        stepper.backgroundColor = AppColor.backgroundMinor
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.roundCorners(.allCorners, radius: Constants.CornerRadius.medium)
        return stepper
    }()
    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImage.UserListIcons.minus, for: .normal)
        button.addTarget(nil, action: #selector(decrementValue), for: .touchUpInside)
        return button
    }()
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImage.UserListIcons.plus, for: .normal)
        button.addTarget(nil, action: #selector(incrementValue), for: .touchUpInside)
        return button
    }()
    private var value: Int
    private var maximumValue: Int

    // MARK: - Construction
    
    init(value: Int, maxValue: Int) {
        self.value = value
        maximumValue = maxValue
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    // MARK: - Functions
    
    func configure(value: Int) {
        self.value = value
        valueLabel.text = "\(value)"
    }

    // MARK: - Private functions
    
    private func configureUI() {
        addSubviews([titleLabel, stepperView])
        stepperView.addSubviews([decrementButton, valueLabel, incrementButton])
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Spacing.small),
            titleLabel.trailingAnchor.constraint(
                equalTo: stepperView.leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            
            stepperView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stepperView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stepperView.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            stepperView.widthAnchor.constraint(equalToConstant: stepperWidth),
            
            incrementButton.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: stepperView.trailingAnchor),
            incrementButton.widthAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            incrementButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            
            valueLabel.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: stepperView.centerXAnchor),
            
            decrementButton.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor),
            decrementButton.leadingAnchor.constraint(equalTo: stepperView.leadingAnchor),
            decrementButton.widthAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            decrementButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight)
        ])
    }
    
    @objc private func decrementValue() {
        if value > minimumValue {
            value -= 1
        } else {
            value = minimumValue
        }
        
        valueLabel.text = "\(value)"
    }
    
    @objc private func incrementValue() {
        if value < maximumValue {
            value += 1
        } else {
            value = maximumValue
        }
        
        valueLabel.text = "\(value)"
    }

    // MARK: - UITableViewDelegate // пример расширения
}
