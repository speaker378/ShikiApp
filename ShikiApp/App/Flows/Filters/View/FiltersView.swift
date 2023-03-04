//
//  FiltersView.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

final class FiltersView: UIView {

    // MARK: - Properties

    var selectedButton = SelectedButton()
    var dataSource = [String]()
    var filtersList: FiltersModel
    let transparentView = UIView()
    let startYear: Int = Constants.Dates.startYearForFilter

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = Constants.CornerRadius.medium
        tableView.backgroundColor = AppColor.backgroundMain
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()

    // MARK: - Private properties

    private let labelOffset: CGFloat = 32
    private let labelHeight: CGFloat = 22
    private let separatorHeight: CGFloat = 2
    private let bottomOffset: CGFloat = 340

    private let ratingLabel = AppLabel(
        title: Texts.FilterLabels.rating,
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        fontСolor: AppColor.textMain
    )

    private let typeLabel = AppLabel(
        title: Texts.FilterLabels.type,
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        fontСolor: AppColor.textMain
    )

    private let statusLabel = AppLabel(
        title: Texts.FilterLabels.status,
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        fontСolor: AppColor.textMain
    )

    private let genreLabel = AppLabel(
        title: Texts.FilterLabels.genre,
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        fontСolor: AppColor.textMain
    )

    private let releaseYearLabel = AppLabel(
        title: Texts.FilterLabels.releaseYear,
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        fontСolor: AppColor.textMain
    )

    private let seasonLabel = AppLabel(
        title: Texts.FilterLabels.season,
        alignment: .left,
        fontSize: AppFont.Style.regularText,
        fontСolor: AppColor.textMain
    )

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textMain
        return view
    }()

    private(set) lazy var ratingSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.rating, isSelect: false)
        button.addTarget(self, action: #selector(ratingSelectTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var typeSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.type, isSelect: false)
        button.addTarget(self, action: #selector(typeSelectTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var statusSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.status, isSelect: false)
        button.addTarget(self, action: #selector(statusSelectTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var genreSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.genre, isSelect: false)
        button.addTarget(self, action: #selector(genreSelectTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var seasonSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.season, isSelect: false)
        button.addTarget(self, action: #selector(seasonSelectTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var releaseYearStartSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.releaseYearStart, isSelect: false)
        button.addTarget(self, action: #selector(releaseYearStartSelectTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var releaseYearEndSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.releaseYearEnd, isSelect: false)
        button.addTarget(self, action: #selector(releaseYearEndSelectTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Construction

    init(filtersList: FiltersModel, defaults: FilterListModel?) {
        self.filtersList = filtersList
        super.init(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(MenuItemsTableViewCell.self)
        configureUI()
        configureDefaults(defaults: defaults)
    }

    required init?(coder _: NSCoder) { nil }

    // MARK: - Private functions

    private func configureDefaults(defaults: FilterListModel?) {
        if let defaults {
            if !defaults.ratingList.isEmpty {
                ratingSelectButton.configurate(text: defaults.ratingList, isSelect: true)
            }
            if !defaults.typeList.isEmpty {
                typeSelectButton.configurate(text: defaults.typeList, isSelect: true)
            }
            if !defaults.statusList.isEmpty {
                statusSelectButton.configurate(text: defaults.statusList, isSelect: true)
            }
            if !defaults.genreList.isEmpty {
                genreSelectButton.configurate(text: defaults.genreList, isSelect: true)
            }
            if !defaults.seasonList.isEmpty {
                seasonSelectButton.configurate(text: defaults.seasonList, isSelect: true)
            }
            if !defaults.releaseYearStart.isEmpty {
                releaseYearStartSelectButton.configurate(text: defaults.releaseYearStart, isSelect: true)
            }
            if !defaults.releaseYearEnd.isEmpty {
                releaseYearEndSelectButton.configurate(text: defaults.releaseYearEnd, isSelect: true)
            }
        }
    }

    private func getCurrentShortDate() -> String {
        return Date().convertToString(with: Constants.DateFormatter.year, relative: false)
    }

    private func yearsTillNow(startYear: Int, endYear: Int) -> [String] {
        var years = [String]()
        for year in (startYear ... endYear).reversed() {
            years.append("\(year)")
        }
        return years
    }

    private func configureUI() {
        [
            ratingLabel,
            typeLabel,
            statusLabel,
            genreLabel,
            releaseYearLabel,
            seasonLabel,
            ratingSelectButton,
            typeSelectButton,
            statusSelectButton,
            genreSelectButton,
            seasonSelectButton,
            releaseYearStartSelectButton,
            separatorView,
            releaseYearEndSelectButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureConstraints()
    }

    private func configureConstraints() {
        setRatingConstraints()
        setTypeConstraints()
        setStatusConstraints()
        setGenreConstraints()
        setReleaseYearConstraints()
        setSeasonYearConstraints()
    }

    private func setRatingConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.Insets.sideInset
            ),
            ratingLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: labelOffset
            ),
            ratingLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -labelOffset
            ),
            ratingLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            ratingSelectButton.topAnchor.constraint(
                equalTo: ratingLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            ratingSelectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            ratingSelectButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            ratingSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight)
        ])
    }

    private func setTypeConstraints() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(
                equalTo: ratingSelectButton.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            typeLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: labelOffset
            ),
            typeLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -labelOffset
            ),
            typeLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            typeSelectButton.topAnchor.constraint(
                equalTo: typeLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            typeSelectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            typeSelectButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            typeSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            statusLabel.topAnchor.constraint(
                equalTo: typeSelectButton.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            statusLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: labelOffset
            )
        ])
    }

    private func setStatusConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -labelOffset
            ),
            statusLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            statusSelectButton.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            statusSelectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            statusSelectButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            statusSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight)
        ])
    }

    private func setGenreConstraints() {
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(
                equalTo: statusSelectButton.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            genreLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: labelOffset
            ),
            genreLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -labelOffset
            ),
            genreLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            genreSelectButton.topAnchor.constraint(
                equalTo: genreLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            genreSelectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            genreSelectButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            genreSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),

            releaseYearLabel.topAnchor.constraint(
                equalTo: genreSelectButton.bottomAnchor,
                constant: Constants.Insets.sideInset
            )
        ])
    }

    private func setReleaseYearConstraints() {
        NSLayoutConstraint.activate([
            releaseYearLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: labelOffset
            ),
            releaseYearLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -labelOffset
            ),
            releaseYearLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            releaseYearStartSelectButton.topAnchor.constraint(
                equalTo: releaseYearLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            releaseYearStartSelectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            releaseYearStartSelectButton.trailingAnchor.constraint(
                equalTo: separatorView.leadingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            releaseYearStartSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),

            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorView.centerYAnchor.constraint(equalTo: releaseYearStartSelectButton.centerYAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: Constants.Insets.sideInset),
            separatorView.heightAnchor.constraint(equalToConstant: separatorHeight),

            releaseYearEndSelectButton.topAnchor.constraint(
                equalTo: releaseYearLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            releaseYearEndSelectButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            releaseYearEndSelectButton.leadingAnchor.constraint(
                equalTo: separatorView.trailingAnchor,
                constant: Constants.Insets.sideInset
            ),
            releaseYearEndSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight)
        ])
    }

    private func setSeasonYearConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(
                equalTo: releaseYearStartSelectButton.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            seasonLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: labelOffset
            ),
            seasonLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -labelOffset
            ),
            seasonLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            seasonSelectButton.topAnchor.constraint(
                equalTo: seasonLabel.bottomAnchor,
                constant: Constants.Spacing.small
            ),
            seasonSelectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            seasonSelectButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            seasonSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            seasonSelectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomOffset)
        ])
    }

    @objc private func ratingSelectTapped() {
        dataSource = filtersList.ratingList
        selectedButton = ratingSelectButton
        addTransparentView(frames: ratingSelectButton.frame)
    }

    @objc private func typeSelectTapped() {
        dataSource = filtersList.typeList
        selectedButton = typeSelectButton
        addTransparentView(frames: typeSelectButton.frame)
    }

    @objc private func statusSelectTapped() {
        dataSource = filtersList.statusList
        selectedButton = statusSelectButton
        addTransparentView(frames: statusSelectButton.frame)
    }

    @objc private func genreSelectTapped() {
        dataSource = filtersList.genreList
        selectedButton = genreSelectButton
        addTransparentView(frames: genreSelectButton.frame)
    }

    @objc private func seasonSelectTapped() {
        dataSource = filtersList.seasonList
        selectedButton = seasonSelectButton
        addTransparentView(frames: seasonSelectButton.frame)
    }

    @objc private func releaseYearStartSelectTapped() {
        if releaseYearEndSelectButton.titleLabel.text != Texts.FilterPlaceholders.releaseYearEnd {
            dataSource = yearsTillNow(
                startYear: startYear,
                endYear: Int(releaseYearEndSelectButton.titleLabel.text ?? "") ?? 0
            )
        } else {
            dataSource = yearsTillNow(
                startYear: startYear,
                endYear: Int(getCurrentShortDate()) ?? 0
            )
        }
        selectedButton = releaseYearStartSelectButton
        addTransparentView(frames: releaseYearStartSelectButton.frame)
    }

    @objc private func releaseYearEndSelectTapped() {
        if releaseYearStartSelectButton.titleLabel.text != Texts.FilterPlaceholders.releaseYearStart {
            dataSource = yearsTillNow(
                startYear: Int(releaseYearStartSelectButton.titleLabel.text ?? "") ?? 0,
                endYear: Int(getCurrentShortDate()) ?? 0
            )
        } else {
            dataSource = yearsTillNow(
                startYear: startYear,
                endYear: Int(getCurrentShortDate()) ?? 0
            )
        }
        selectedButton = releaseYearEndSelectButton
        addTransparentView(frames: releaseYearEndSelectButton.frame)
    }
}
