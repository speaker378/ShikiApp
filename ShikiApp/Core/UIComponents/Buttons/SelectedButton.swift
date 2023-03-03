//
//  SelectedButton.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

class SelectedButton: UIControl {

    // MARK: - Properties

    let titleLabel = AppLabel(
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        numberLines: 1
    )

    // MARK: - Private properties

    private let imageView: UIImageView = {
        let image = UIImageView(
            frame:
                CGRect(
                    x: .zero,
                    y: .zero,
                    width: Constants.Insets.iconMediumHeight,
                    height: Constants.Insets.iconMediumHeight
                )
        )
        image.image = AppImage.NavigationsBarIcons.chevronDown
        return image
    }()
    
    private var isSelect: Bool = false

    // MARK: - Construction

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColor.backgroundMinor
        addSubviewsContent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func configurate(text: String, isSelect: Bool) {
        titleLabel.text = text
        titleLabel.textColor = isSelect  ? AppColor.textMain : AppColor.textMinor
    }
    
    func configurate(text: String, image: UIImage) {
        titleLabel.text = text
        titleLabel.textColor = AppColor.textMain
        imageView.image = image
    }

    // MARK: - Private functions

    private func configureUI() {
        self.layer.cornerRadius = Constants.CornerRadius.medium
        self.clipsToBounds = true
        configureConstraints()
    }
    
    private func addSubviewsContent() {
        [
            titleLabel,
            imageView
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            titleLabel.widthAnchor.constraint(equalToConstant: bounds.width - Constants.Insets.sideInset * 2
                                              - Constants.Insets.iconMediumHeight),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Spacing.medium)
        ])
    }
}
