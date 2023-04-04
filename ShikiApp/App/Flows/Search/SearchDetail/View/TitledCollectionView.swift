//
//  TitledCollectionView.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.04.2023.
//

import UIKit

class TitledCollectionView: UIView {

// MARK: - Private properties

    private static let headerHeight = 46.0    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundMain
        return view
    }()
    private let baseLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundMinor
        view.layer.cornerRadius = Constants.CornerRadius.small
        view.layer.masksToBounds = true
        return view
    }()
    private let descriptionLabel: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.blockTitle, numberLines: 1)
        return label
    }()
    private let appCollectionView: AppCollectionView

    // MARK: - Constructions

    init(title: String, imageURLStrings: [String], imageComments: [String?]? = nil,
         itemTapCompletion: ((String) -> Void)? = nil) {
        descriptionLabel.text = title
        appCollectionView = AppCollectionView(
            imageURLStrings: imageURLStrings,
            imageComments: imageComments
        )
        appCollectionView.itemTapCompletion = itemTapCompletion
        super.init(frame: .zero)
        configure()
        if imageURLStrings.isEmpty {
            self.isHidden = true
            self.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    private func configure() {
        baseLayerView.addSubview(descriptionLabel)
        backgroundView.addSubview(baseLayerView)
        addSubviews(backgroundView, appCollectionView)
        [backgroundView, baseLayerView, descriptionLabel, appCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: Self.headerHeight),
            baseLayerView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: Constants.Spacing.medium
            ),
            baseLayerView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Constants.Spacing.medium),
            baseLayerView.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -Constants.Spacing.medium
            ),
            baseLayerView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -Constants.Spacing.medium
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: baseLayerView.leadingAnchor,
                constant: Constants.Spacing.medium
            ),
            descriptionLabel.topAnchor.constraint(equalTo: baseLayerView.topAnchor, constant: Constants.Spacing.small),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: baseLayerView.trailingAnchor,
                constant: -Constants.Spacing.medium
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: baseLayerView.bottomAnchor,
                constant: -Constants.Spacing.small
            ),
            appCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            appCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            appCollectionView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            appCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
