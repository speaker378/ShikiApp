//
//  StepperView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 12.03.2023.
//

import UIKit

protocol StepperViewDataSource: AnyObject {
    
    func stepperViewMaximumValue(_ stepperView: StepperView) -> Int?
    func stepperViewCurrentValue(_ stepperView: StepperView) -> Int
    func stepperViewTitle(_ stepperView: StepperView) -> String
}

protocol StepperViewDelegate: AnyObject {
    
    /// Значение степпера было изменено
    func stepperViewValueWasChanged(_ stepperView: StepperView, value: Int, maxValue: Int?)
    /// Закончили изменение значений степпера
    func stepperViewDidFinishValueChanges(_ stepperView: StepperView, value: Int)
}

final class StepperView: UIView {

    // MARK: - Properties
    
    weak var delegate: StepperViewDelegate?
    weak var dataSource: StepperViewDataSource? {
        didSet {
            configure()
        }
    }
    private(set) var value = 0 {
        didSet {
            changeButtonState()
        }
    }
    private(set) var maximumValue: Int?

    // MARK: - Private properties
    
    private let stepperWidth: CGFloat = 160.0
    private let changingValueDuration = 0.1
    private let longTouchDuration = 0.6
    private let titleLabel: AppLabel = {
        let label = AppLabel(title: Texts.DetailLabels.episodes, alignment: .left, fontSize: AppFont.Style.regularText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.pageTitle)
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
        button.addTarget(nil, action: #selector(touchEnded), for: [.touchUpInside, .touchUpOutside])
        button.addTarget(nil, action: #selector(decrementValue), for: .touchDown)
        return button
    }()
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImage.UserListIcons.plus, for: .normal)
        button.addTarget(nil, action: #selector(touchEnded), for: [.touchUpInside, .touchUpOutside])
        button.addTarget(nil, action: #selector(incrementValue), for: .touchDown)
        return button
    }()
    private var touchFinishedTimer: Timer?
    private var touchStartedTimer: Timer?
    private var touchDurationTimer: Timer?
    private var hasLongPress = false
    private var longPressCount = 0

    // MARK: - Construction
    
    init(title: String, value: Int = 0, maxValue: Int? = nil) {
        self.value = value
        maximumValue = maxValue
        titleLabel.text = title
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func configure(value: Int) {
        self.value = value
        valueLabel.text = "\(value)"
    }

    // MARK: - Private functions
    
    private func configure() {
        if let newMaxValue = dataSource?.stepperViewMaximumValue(self) {
            maximumValue = newMaxValue
        }
        
        if let newTitle = dataSource?.stepperViewTitle(self) {
            titleLabel.text = newTitle
        }
        
        if let newValue = dataSource?.stepperViewCurrentValue(self) {
            value = newValue
        }
    }
    
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
    
    private func disableButton(_ sender: UIButton) {
        sender.isEnabled = false
        sender.layer.opacity = 0.5
    }
    
    private func enableButton(_ sender: UIButton) {
        sender.isEnabled = true
        sender.layer.opacity = 1.0
    }
    
    /// Смена состояний кнопок
    private func changeButtonState() {
        if let maximumValue = self.maximumValue, value < maximumValue {
            enableButton(incrementButton)
        } else if value == maximumValue {
            disableButton(incrementButton)
        }
        if value > minimumValue {
            enableButton(decrementButton)
        } else if value == minimumValue {
            disableButton(decrementButton)
        }
    }
    
    /// Для изменения значения по нажатию на кнопку. 
    private func changeValue(with sender: UIButton) {
        if !hasLongPress {
            switch sender {
            case decrementButton:
                if value > minimumValue {
                    value -= 1
                } else {
                    value = minimumValue
                }
            case incrementButton:
                if let maximumValue = self.maximumValue, value >= maximumValue {
                    value = maximumValue
                } else {
                    value += 1
                }
            default: break
            }
            delegate?.stepperViewValueWasChanged(self, value: value, maxValue: maximumValue)
        }
        valueLabel.text = "\(value)"
        hasLongPress = false
    }
    
    /// Для плавного уменьшения значения. Чем дольше юзер зажимает кнопку, тем сильнее меняем значение
    private func longPressDecrementValue() {
        self.longPressCount = 0
        self.touchDurationTimer = Timer.scheduledTimer(
            withTimeInterval: changingValueDuration,
            repeats: true,
            block: { [weak self] _ in
            guard let self else { return }
            self.longPressCount += 1
            if self.value > self.minimumValue {
                self.value -= max(self.longPressCount * self.longPressCount / 20, 1)
            } else {
                self.value = self.minimumValue
            }
            self.valueLabel.text = "\(self.value)"
        }
        )
    }
    
    /// Для плавного увеличения значения. Чем дольше юзер зажимает кнопку, тем сильнее меняем значение
    private func longPressIncrementValue() {
        longPressCount = 0
        touchDurationTimer = Timer.scheduledTimer(
            withTimeInterval: changingValueDuration,
            repeats: true,
            block: { [weak self] _ in
                guard let self else { return }
                self.longPressCount += 1
                if let maximumValue = self.maximumValue, self.value >= maximumValue {
                    self.value = maximumValue
                } else {
                    self.value += max(self.longPressCount * self.longPressCount / 20, 1)
                }
                self.valueLabel.text = "\(self.value)"
            }
        )
    }
    
    @objc private func decrementValue(_ sender: UIButton) {
        touchStartedTimer?.invalidate()
        touchStartedTimer = Timer.scheduledTimer(
            withTimeInterval: longTouchDuration,
            repeats: false,
            block: { [weak self] _ in
                guard let self else { return }
                self.hasLongPress = true
                self.longPressDecrementValue()
            }
        )
        
        delegate?.stepperViewValueWasChanged(self, value: value, maxValue: maximumValue)
    }
    
    @objc private func incrementValue(_ sender: UIButton) {
        touchStartedTimer?.invalidate()
        touchStartedTimer = Timer.scheduledTimer(
            withTimeInterval: longTouchDuration,
            repeats: false,
            block: { [weak self] _ in
                guard let self else { return }
                self.hasLongPress = true
                self.longPressIncrementValue()
            }
        )
        
        delegate?.stepperViewValueWasChanged(self, value: value, maxValue: maximumValue)
    }
    
    @objc private func touchEnded(_ sender: UIButton) {
        touchFinishedTimer?.invalidate()
        touchDurationTimer?.invalidate()
        touchStartedTimer?.invalidate()
        
        changeValue(with: sender)
        
        // Ждём некоторое время, затем отдаем последнее значение степпера для дальнейшей обработки
        touchFinishedTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] _ in
            guard let self else { return }
            self.delegate?.stepperViewDidFinishValueChanges(self, value: self.value)
        })
    }
}
