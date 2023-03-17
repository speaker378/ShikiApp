//
//  ScoringView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 16.03.2023.
//

import UIKit

protocol ScoringViewDelegate: AnyObject {
    
    func scoringViewDidTouched(_ scoringView: ScoringView, score: Int)
    func scoringViewDidFinishTouching(_ scoringView: ScoringView, score: Int)
}

final class ScoringView: UIView {

    // MARK: - Properties
    
    var minTouchScore = 1
    weak var delegate: ScoringViewDelegate?

    // MARK: - Private properties
    
    private let isLabelDisplayed = UIScreen.main.bounds.width > 320.0
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
    private var previousScore: Int
    private var starImageViews = [UIImageView]()

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
        delegate?.scoringViewDidFinishTouching(self, score: score)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard touchLocationFromBeginningOfRating(touches) != nil else { return }
        delegate?.scoringViewDidFinishTouching(self, score: score)
    }

    // MARK: - Private functions
    
    private func configureUI() {
        starStackView.spacing = spacing
        
        for index in 0...totalNumberOfStars - 1 {
            let starImage = index < score
                ? AppImage.UserListIcons.starFilled
                : AppImage.UserListIcons.star
            let imageView = UIImageView(image: starImage)
            
            starImageViews.append(imageView)
        }
        
        starImageViews.forEach { starStackView.addArrangedSubview($0) }
        updateLabelText(score: score)
        addSubviews([starStackView, scoreValueLabel])
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: viewHeight),

            starStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(
                equalTo: scoreValueLabel.leadingAnchor,
                constant: Constants.Insets.sideInset
            ),

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
        guard isLabelDisplayed else { return }
        scoreValueLabel.text = score > 0 ? String(score) : "–"
        scoreValueLabel.textColor = score > 0 ? AppColor.textMain : AppColor.textMinor
    }

    private func touchLocationFromBeginningOfRating(_ touches: Set<UITouch>) -> CGFloat? {
        guard let touch = touches.first else { return nil }
        return touch.location(in: self).x
    }
    
    private func onDidTouch(_ locationX: CGFloat) {
        let calculatedTouchRating = touchRating(locationX)
        guard calculatedTouchRating != previousScore else { return }
        self.score = calculatedTouchRating
        previousScore = calculatedTouchRating
        updateStarImages(score: calculatedTouchRating)
    }
    
    // TODO: - вынести куда-нибудь логику
    private func touchRating(_ positionX: CGFloat) -> Int {
        let correction = starSize.width / 3
        var scoresWidth = 0.0
        var score = 0
        
        while positionX > scoresWidth + correction {
            let currentScoreWidth = score == totalNumberOfStars ? starSize.width : starSize.width + spacing
            scoresWidth += currentScoreWidth
            score += 1
        }
        
        return max(minTouchScore, score)
    }
}
