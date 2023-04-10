//
//  UserRatesTableViewCell.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

class UserRatesTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private let lineHeight: CGFloat = 1
    private let scoreWidth: CGFloat = 39
    private let scoreHeight: CGFloat = 24
    private let spacing: CGFloat = 21
    private let inset = 12.0
    private let verticalSpacing = 2.0

    private let contentImageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let scoreLabel: UILabel = {
        let label = AppLabel(
            alignment: .center,
            fontSize: AppFont.Style.blockTitle,
            fontСolor: AppColor.textInvert
        )
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = AppLabel(
            alignment: .left,
            fontSize: AppFont.Style.blockTitle,
            fontСolor: AppColor.textMain
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
       
        return label
    }()
    
    private let kindleLabel: UILabel = {
        let label = AppLabel(
            alignment: .left,
            fontSize: AppFont.Style.regularText,
            fontСolor: AppColor.textMain
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var statusChipsView: ChipsView = {
        let view = ChipsView(title: "", style: .lightGray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: Constants.Insets.iconMediumHeight,
            height: Constants.Insets.iconMediumHeight
        ))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let watchingEpisodesLabel: UILabel = {
        let label = AppLabel(
            alignment: .left,
            fontSize: AppFont.Style.regularText,
            fontСolor: AppColor.textMain
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalEpisodesLabel: UILabel = {
        let label = AppLabel(
            alignment: .left,
            fontSize: AppFont.Style.regularText,
            fontСolor: AppColor.textMinor
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var accentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundMinor
        return view
    }()
    
    private var strokeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.line
        return view
    }()

    // MARK: - Construction

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [
            contentImageView,
            statusImageView
        ].forEach {
            $0.image = nil
        }
        [
            scoreLabel,
            titleLabel,
            kindleLabel,
            watchingEpisodesLabel,
            totalEpisodesLabel
        ].forEach {
            $0.text = nil
        }
    }

    // MARK: - Functions

    func configure(with cellModel: UserRatesModel) {
        contentImageView.downloadedImage(from: cellModel.imageUrlString, contentMode: .scaleAspectFill)
        titleLabel.text = cellModel.title
        scoreLabel.text = cellModel.score.value
        scoreLabel.backgroundColor = cellModel.score.color
        kindleLabel.text = cellModel.kind
        statusImageView.image = cellModel.statusImage
        watchingEpisodesLabel.text = cellModel.watchingEpisodes
        totalEpisodesLabel.text = cellModel.totalEpisodes
        statusChipsView.configurate(
            title: cellModel.ongoingStatus,
            style: ChipsStyle.makeStatusStyle(cellModel.ongoingStatus)
        )
    }

    // MARK: - Private functions

    private func configureUI() {
        self.selectedBackgroundView = accentBackgroundView
        self.backgroundColor = AppColor.backgroundMain
        self.addSubviews(
            [
                contentImageView,
                scoreLabel,
                titleLabel,
                kindleLabel,
                statusChipsView,
                statusImageView,
                watchingEpisodesLabel,
                totalEpisodesLabel,
                strokeView
            ]
        )
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupСontentImageConstraints()
        setupHeaderViewConstraints()
        setupFooterViewConstraints()
    }
    
    private func setupСontentImageConstraints() {
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: topAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentImageView.widthAnchor.constraint(equalToConstant: Constants.Insets.coverWidth),
            contentImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scoreLabel.leadingAnchor.constraint(
                equalTo: contentImageView.leadingAnchor,
                constant: Constants.Spacing.medium
            ),
            scoreLabel.widthAnchor.constraint(equalToConstant: scoreWidth),
            scoreLabel.heightAnchor.constraint(equalToConstant: scoreHeight),
            scoreLabel.topAnchor.constraint(
                equalTo: contentImageView.topAnchor,
                constant: Constants.Spacing.medium
            )
        ])
    }
    
    private func setupHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: contentImageView.trailingAnchor,
                constant: Constants.Spacing.medium
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            
            kindleLabel.leadingAnchor.constraint(
                equalTo: contentImageView.trailingAnchor,
                constant: Constants.Spacing.medium
            ),
            kindleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalSpacing),

            statusChipsView.leadingAnchor.constraint(
                equalTo: kindleLabel.trailingAnchor,
                constant: Constants.Spacing.medium
            ),
            statusChipsView.centerYAnchor.constraint(equalTo: kindleLabel.centerYAnchor)
        ])
    }
    
    private func setupFooterViewConstraints() {
        NSLayoutConstraint.activate([
            statusImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            statusImageView.topAnchor.constraint(equalTo: kindleLabel.bottomAnchor, constant: spacing),
            
            watchingEpisodesLabel.leadingAnchor.constraint(
                equalTo: statusImageView.trailingAnchor,
                constant: Constants.Spacing.small
            ),
            watchingEpisodesLabel.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor),
            
            totalEpisodesLabel.leadingAnchor.constraint(
                equalTo: watchingEpisodesLabel.trailingAnchor,
                constant: Constants.Spacing.small
            ),
            totalEpisodesLabel.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor),
            
            strokeView.leadingAnchor.constraint(
                equalTo: contentImageView.trailingAnchor,
                constant: Constants.Spacing.medium
            ),
            strokeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            strokeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            strokeView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
    }
}
