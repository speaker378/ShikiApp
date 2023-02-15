//
//  CounterButton.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 06.02.2023.
//

import UIKit

final class CounterButton: UIButton {

    // MARK: - Private Properties

    private let counterViewFactor = 0.333
    private let mainViewFactor = 0.417
    private let counterViewTopOffset = 2.0
    private let counterViewTrailingInset = -2.0
    private var counterView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var mainView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
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

    // MARK: - Functions

    func setImage(image: UIImage) -> Self {
        mainView.image = image
        return self
    }
    
    func setImageColor(color: UIColor) -> Self {
        mainView.tintColor = color
        return self
    }
    
    func setCounterColor(color: UIColor) -> Self {
        counterView.tintColor = color
        return self
    }
    
    func setCounter(counter: Int?) -> Self {
        counterView.isHidden = (counter == nil || counter == 0)
        if let counter {
            counterView.image = counterImage(count: counter)
            counterView.isOpaque = true
            counterView.alpha = 1.0
        }
        return self
    }

    // MARK: - Private functions

    private func counterImage(count: Int?) -> UIImage {
        guard let count else { return UIImage() }
        return UIImage(systemName: "\(count).circle.fill") ?? UIImage()
    }

    private func configureUI() {
        counterView.backgroundColor = backgroundColor
        mainView.backgroundColor = backgroundColor
        addSubviews(mainView, counterView)
        layer.masksToBounds = true
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: mainViewFactor),
            mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: counterViewFactor),
            counterView.heightAnchor.constraint(equalTo: counterView.widthAnchor),
            counterView.topAnchor.constraint(equalTo: topAnchor, constant: counterViewTopOffset),
            counterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: counterViewTrailingInset)
        ])
    }
}
