//
//  ButtonWithIconView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 16.02.2023.
//

import UIKit

final class ButtonWithIconView: UIView {

    // MARK: - Properties
    
    var tapHandler: (() -> Void)?

    // MARK: - Private properties
    
    private let imageView = UIImageView()
    private let titleLabel: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.blockTitle, fontСolor: AppColor.textInvert)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Construction
    
    init(title: String, icon: UIImage) {
        super.init(frame: .zero)
        configure(with: title, icon: icon)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure(with title: String, icon: UIImage) {
        backgroundColor = AppColor.accent
        layer.cornerRadius = Constants.CornerRadius.medium
        imageView.image = icon
        titleLabel.text = title
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gesture)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        addSubviews([titleLabel, imageView])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.Insets.iconMediumHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constants.Spacing.medium)
        ])
    }
    
    @objc private func tapped() {
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.layer.opacity = 0.9
        } completion: { _ in
            self.layer.opacity = 1.0
        }
        tapHandler?()
    }
}
