//
//  ItemInfoView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

final class ItemInfoView: UIView {

    // MARK: - Private properties
    
    private let coverHeight: CGFloat = UIScreen.main.bounds.width > 320 ? 240.0 : 200.0
    private let coverWidth: CGFloat = UIScreen.main.bounds.width > 320 ? 168.0 : 140.0
    private let spacing: CGFloat  = 4.0
    private let scoreLabelHeight: CGFloat = 38.0
    private let infoLabelHeight: CGFloat = 16.0
    private let coverImageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.layer.cornerRadius = Constants.CornerRadius.medium
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scoreLabel: AppLabel = {
        let label = AppLabel(alignment: .right, fontSize: AppFont.Style.pageLargeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeAndDateLabel: AppLabel = {
        let label = AppLabel(alignment: .right, fontSize: AppFont.Style.subtitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodesLabel: AppLabel = {
        let label = AppLabel(alignment: .right, fontSize: AppFont.Style.subtitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let durationLabel: AppLabel = {
        let label = AppLabel(alignment: .right, fontSize: AppFont.Style.subtitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ratingChipsView: ChipsView?
    private var statusChipsView: ChipsView
    private var studioView: UIView?

    // MARK: - Construction
    
    init(content: SearchDetailModel) {
        statusChipsView = ChipsView(title: content.status, style: ChipsStyle.makeStatusStyle(content.status))
        super.init(frame: .zero)
        ratingChipsView = makeRatingView(with: content)
        studioView = makeStudioView(with: content)
        configure(with: content)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure(with content: SearchDetailModel) {
        coverImageView.downloadedImage(from: content.imageUrlString)
        scoreLabel.text = content.score
        typeAndDateLabel.text = "\(content.kindAndDate)"
        episodesLabel.text = makeEpisodesText(with: content)
        durationLabel.text = content.durationOrVolumes
        
        configureUI()
    }
    
    private func configureUI() {
        addSubviews([coverImageView, scoreLabel, typeAndDateLabel, episodesLabel, durationLabel, statusChipsView])
        
        configureConstraints()
        configureRatingView()
        configureStudioView()
    }
    
    private func makeRatingView(with content: SearchDetailModel) -> ChipsView? {
        guard let rating = content.rating else { return nil }
        let view = ChipsView(title: rating, style: .lightGray)
        return view
    }
    
    private func makeStudioView(with content: SearchDetailModel) -> UIStackView? {
        guard !content.studios.isEmpty else { return nil }
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Spacing.small
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        content.studios.forEach { string in
            let label = AppLabel(title: string, alignment: .center, fontSize: AppFont.Style.subtitle)
            label.setContentHuggingPriority(UILayoutPriority(1000.0), for: .horizontal)
            stackView.addArrangedSubview(label)
        }
        return stackView
    }
    
    private func configureRatingView() {
        guard let ratingView = ratingChipsView else { return }
        addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: Constants.Spacing.medium),
            ratingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureStudioView() {
        guard let studioView = studioView else { return }
        addSubview(studioView)
        let bottomAnchorView = ratingChipsView ?? durationLabel
        
        NSLayoutConstraint.activate([
            studioView.topAnchor.constraint(
                equalTo: bottomAnchorView.bottomAnchor,
                constant: Constants.Spacing.medium
            ),
            studioView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureConstraints() {
        statusChipsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: coverHeight),
            coverImageView.widthAnchor.constraint(equalToConstant: coverWidth),
            
            scoreLabel.topAnchor.constraint(equalTo: topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            scoreLabel.heightAnchor.constraint(equalToConstant: scoreLabelHeight),
            
            typeAndDateLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: Constants.Spacing.medium),
            typeAndDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            typeAndDateLabel.heightAnchor.constraint(equalToConstant: infoLabelHeight),
            
            episodesLabel.centerYAnchor.constraint(equalTo: statusChipsView.centerYAnchor),
            episodesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            episodesLabel.heightAnchor.constraint(equalToConstant: infoLabelHeight),
            episodesLabel.leadingAnchor.constraint(equalTo: statusChipsView.trailingAnchor, constant: spacing),
            
            statusChipsView.topAnchor.constraint(
                equalTo: typeAndDateLabel.bottomAnchor,
                constant: Constants.Spacing.medium
            ),
            
            durationLabel.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: Constants.Spacing.medium),
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            durationLabel.heightAnchor.constraint(equalToConstant: infoLabelHeight),
            
            heightAnchor.constraint(equalToConstant: coverHeight)
        ])
    }
    
    private func makeEpisodesText(with content: SearchDetailModel) -> String {
        guard let episodesCount = content.episodes, content.kind != "Фильм" else { return "" }
        let episodes = episodesCount == 0 ? " ?" : String(episodesCount)
        var string = ""
        if content.status == "Выходит" || content.status == "Онгоинг", let aired = content.episodesAired {
            string = "\(aired)/\(episodes) \(Texts.OtherMessage.episodes)"
        } else {
            string = "\(episodes) \(Texts.OtherMessage.episodes)"
        }
        return string
    }
}
