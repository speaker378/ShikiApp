//
//  ScoringView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 16.03.2023.
//

import UIKit

final class ScoringView: UIView {

    // MARK: - Properties
    
    /// Set to `false` if you don't want to pass touches to superview (can be useful in a table view).
    var hasLetPassTouchesToSuperview = false
    /// The lowest rating that user can set by touching the stars.
    var minTouchRating = 1
    var previousRatingForDidTouchCallback: Int
    
    //    /// Set to `true` if you want to ignore pan gestures (can be useful when presented modally with a `presentationStyle` of `pageSheet` to avoid competing with the dismiss gesture)
    //    public var disablePanGestures = false
    
    // TODO: - заменить на делегат
    /// Closure will be called when user touches the cosmos view. The touch rating argument is passed to the closure.
    var didTouchCosmos: ((Int) -> Void)?
    
    /// Closure will be called when the user lifts finger from the cosmos view. The touch rating argument is passed to the closure.
    var didFinishTouchingCosmos: ((Int) -> Void)?

    // MARK: - Private properties
    
//    private let isLabelDisplayed = UIScreen.main.bounds.width > 320.0
    private let viewHeight: CGFloat = 40.0
    private let spacing: CGFloat = 0.0
    private let starSize = CGSize(width: 28.0, height: 28.0)
    private let totalNumberOfStars: Int
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        return stackView
    }()
    private let scoreValueLabel: AppLabel = {
        let label = AppLabel(title: "", alignment: .right, fontSize: AppFont.Style.pageTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var score: Int
    private var starImageViews = [UIImageView]()

    // MARK: - Construction
    
    init(score: Int = 0, totalNumberOfStars: Int = 10) {
        self.score = score < totalNumberOfStars ? score : totalNumberOfStars
        self.totalNumberOfStars = totalNumberOfStars
        self.previousRatingForDidTouchCallback = score
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touchLocationFromBeginningOfRating(touches) else { return }
        print("@@ touchesBegan: location = \(location)")
        onDidTouch(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touchLocationFromBeginningOfRating(touches) else { return }
        print("@@ touchesMoved: location = \(location)")
        onDidTouch(location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touchLocationFromBeginningOfRating(touches) else { return }
        print("@@ touchesEnded: last location = \(location)")
        didFinishTouchingCosmos?(score)
    }
    
     /// Detecting event when the touches are cancelled (can happen in a scroll view).
     /// Behave as if user has lifted their finger.
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard let location = touchLocationFromBeginningOfRating(touches) else { return }
        print("@@ touchesCancelled: last location = \(location)")
        didFinishTouchingCosmos?(score)
    }

    // MARK: - Private functions
    
    private func configureUI() {
        starStackView.spacing = spacing
        
        for index in 0...totalNumberOfStars - 1 {
            let starImage = index > 0 && index < score
            ? AppImage.UserListIcons.starFilled
            : AppImage.UserListIcons.star
            let imageView = UIImageView(image: starImage)
            
            starImageViews.append(imageView)
        }
        
        starImageViews.forEach { starStackView.addArrangedSubview($0) }
        
        updateStarImages(score: score)
        addSubviews([starStackView, scoreValueLabel])
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40.0),

            starStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(equalTo: scoreValueLabel.leadingAnchor, constant: 16.0),

            scoreValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
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
//        guard isLabelDisplayed else { return }
        
        scoreValueLabel.text = score > 0 ? String(score) : "–"
        scoreValueLabel.textColor = score > 0 ? AppColor.textMain : AppColor.textMinor
    }

    /// Returns the distance of the touch relative to the left edge of the first star
    private func touchLocationFromBeginningOfRating(_ touches: Set<UITouch>) -> CGFloat? {
        guard let touch = touches.first else { return nil }
        let location = touch.location(in: self).x
        print("@@ touchLocationFromBeginningOfRating: location = \(location)")
        return location
    }
    
    private func onDidTouch(_ locationX: CGFloat) {
        let calculatedTouchRating = touchRating(locationX)
        guard calculatedTouchRating != previousRatingForDidTouchCallback else { return }
        self.score = calculatedTouchRating
        previousRatingForDidTouchCallback = calculatedTouchRating
        print("@@ User choose score \(self.score)?")
        updateStarImages(score: calculatedTouchRating)
    }
    
    private func touchRating(_ positionX: CGFloat) -> Int {
        let correction = starSize.width / 3
        var scoresWidth = 0.0
        var score = 0
        
        while positionX > scoresWidth + correction {
            let currentScoreWidth = score == totalNumberOfStars ? starSize.width : starSize.width + spacing
            scoresWidth += currentScoreWidth
            score += 1
            print("@@ user: scoresWidth \(scoresWidth) >= positionХ\(positionX)? score = \(score)")
        }
        
        return max(minTouchRating, score)
    }
}
