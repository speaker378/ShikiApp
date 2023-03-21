//
//  ScoringView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 16.03.2023.
//

import UIKit

final class ScoringView: UIView {

    // MARK: - Properties
    
    var minTouchScore = 1
    var didChangedValueCompletion: ((Int) -> Void)?

    // MARK: - Private properties
    
    private let totalNumberOfStars: Int
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let scoreValueLabel: AppLabel = {
        let label = AppLabel(title: "", alignment: .right, fontSize: AppFont.Style.pageTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var score: Int
    private var previousScore: Int
    private var starImageViews = [UIImageView]()
    private var starSize = CGSize(width: 28.0, height: 28.0)

    // MARK: - Construction
    
    init(score: Int = 0, totalNumberOfStars: Int = 10) {
        self.score = score < totalNumberOfStars ? score : totalNumberOfStars
        self.totalNumberOfStars = totalNumberOfStars
        self.previousScore = score
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateStarSize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touchLocationFromBeginningOfRating(touches) else { return }
        onDidTouch(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touchLocationFromBeginningOfRating(touches) else { return }
        onDidTouch(location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchLocationFromBeginningOfRating(touches) != nil else { return }
        didChangedValueCompletion?(score)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard touchLocationFromBeginningOfRating(touches) != nil else { return }
        didChangedValueCompletion?(score)
    }

    // MARK: - Private functions
    
    private func configureUI() {
        starStackView.spacing = Constants.Spacing.small
        
        for index in 0...totalNumberOfStars - 1 {
            let starImage = index < score
                ? AppImage.UserListIcons.starFilled
                : AppImage.UserListIcons.star
            
            let imageView = UIImageView(image: starImage)
            imageView.contentMode = .scaleAspectFit
            
            starImageViews.append(imageView)
        }
        starImageViews.forEach { starStackView.addArrangedSubview($0) }
        updateLabelText(score: score)
        addSubviews([starStackView, scoreValueLabel])
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),

            starStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            starStackView.trailingAnchor.constraint(
//                equalTo: scoreValueLabel.leadingAnchor,
//                constant: Constants.Insets.sideInset
//            ),

            scoreValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreValueLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            )
        ])
    }
    
    private func updateStarImages(score: Int) {
        for index in 0...totalNumberOfStars - 1 {
            let starImage = index < score ? AppImage.UserListIcons.starFilled : AppImage.UserListIcons.star
            starImageViews[index].image = starImage
        }
        updateLabelText(score: score)
    }
    
    private func updateLabelText(score: Int) {
//        guard isNarrowDevice else { return }
//        scoreValueLabel.text = score > 0 ? String(score) : "–"
//        scoreValueLabel.textColor = score > 0 ? AppColor.textMain : AppColor.textMinor
    }

    private func touchLocationFromBeginningOfRating(_ touches: Set<UITouch>) -> CGFloat? {
        guard let touch = touches.first else { return nil }
        return touch.location(in: self).x
    }
    
    private func onDidTouch(_ locationX: CGFloat) {
        let calculatedTouchRating = touchRating(locationX)
        guard calculatedTouchRating != previousScore else { return }
        score = calculatedTouchRating
        previousScore = calculatedTouchRating
        updateStarImages(score: calculatedTouchRating)
    }
    
    // TODO: - вынести куда-нибудь логику
    private func touchRating(_ positionX: CGFloat) -> Int {
        // для компенсации отступов внутри картинки со звездочкой
        let correction = starSize.width / 8
        var scoresWidth = 0.0
        var score = 0
        
        while positionX > scoresWidth + correction {
            let currentWidth = score == totalNumberOfStars ? starSize.width : starSize.width + starStackView.spacing
            scoresWidth += currentWidth
            score += 1
        }
        
        return max(minTouchScore, score)
    }
    
    private func calculateStarSize() {
        let paddingWidth = starStackView.spacing * CGFloat(totalNumberOfStars - 1)
        let screenWidth = UIScreen.main.bounds.width - Constants.Insets.sideInset * 2 - paddingWidth
        let width = screenWidth / CGFloat(totalNumberOfStars)
        starSize = CGSize(width: width, height: width)
        print("@@ new starSize = \(starSize)")
    }
}
