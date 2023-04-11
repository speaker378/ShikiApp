//
//  ErrorView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 10.04.2023.
//

import UIKit

final class ErrorView: UIView {

    // MARK: - Private properties
    
    private let imageWidth: CGFloat = 120.0
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Spacing.large
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let errorLabel: UILabel = {
        let label = AppLabel(
            alignment: .center,
            fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
            fontСolor: AppColor.textMinor,
            numberLines: 0
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Construction
    
    init(image: UIImage, text: String) {
        errorImageView.image = image
        errorLabel.text = text
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func configure(image: UIImage? = nil, text: String) {
        errorImageView.image = image ?? errorImageView.image
        errorLabel.text = text
    }

    // MARK: - Private functions
    
    private func configureUI() {
        addSubview(contentView)
        [errorImageView, errorLabel].forEach { contentView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            errorImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            errorImageView.heightAnchor.constraint(equalToConstant: imageWidth)
        ])
    }
}
