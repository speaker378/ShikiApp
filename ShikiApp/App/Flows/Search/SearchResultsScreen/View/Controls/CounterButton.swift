//
//  CounterButton.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 06.02.2023.
//

import UIKit

class CounterButton: UIButton {

    // MARK: - Private Properties

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
            mainView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.417),
            mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.333),
            counterView.heightAnchor.constraint(equalTo: counterView.widthAnchor),
            counterView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            counterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
