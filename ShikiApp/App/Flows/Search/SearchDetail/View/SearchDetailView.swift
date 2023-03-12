//
//  SearchDetailView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

final class SearchDetailView: UIView {

    // MARK: - Private properties
    
    private let inset: CGFloat = 24.0
    private let infoViewWidth: CGFloat = UIScreen.main.bounds.width - Constants.Insets.sideInset * 2
    private let itemInfoView: ItemInfoView
    private let genreTableView: ChipsTableView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let button: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.ButtonTitles.addToList, image: AppImage.OtherIcons.addToList)
        button.backgroundColor = AppColor.accent
        button.titleLabel.textColor = AppColor.textInvert
        button.titleLabel.font = AppFont.Style.blockTitle
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let titleLabel: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.title, numberLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: AppLabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.Style.regularText, numberLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let transparentView = UIView()
    private let listTableView: ListTableView
    private let stepperView: StepperView
    private let userRateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Spacing.medium
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    private var content: SearchDetailModel
    private var buttonTapHandler: (() -> Void)?

    // MARK: - Construction
    
    init(content: SearchDetailModel, tapHandler: @escaping () -> Void) {
        self.content = content
        itemInfoView = ItemInfoView(content: content)
        genreTableView = ChipsTableView(values: content.genres)
        listTableView = ListTableView(values: content.rateList)
        buttonTapHandler = tapHandler
        stepperView = StepperView(value: 0, maxValue: content.episodes ?? 0)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure() {
        addSubview(scrollView)
        configureButton()
        configureStepper()
        userRateStackView.addArrangedSubview(button)
        userRateStackView.addArrangedSubview(stepperView)
        scrollView.addSubviews([itemInfoView, userRateStackView, titleLabel, genreTableView, descriptionLabel])
        [itemInfoView, genreTableView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        genreTableView.reloadData()
        configureUI()
    }
    
    private func configureStepper() {
        guard let userRate = content.userRate else {
            stepperView.isHidden = true
            return
        }
        
        stepperView.isHidden = false
        
        var max = 0
        if let episodes = content.episodes {
            max = episodes
        }
        if let aired = content.episodesAired, aired < max {
            max = aired
        }
        
        configureStepperValues(
            status: userRate.status,
            currentValue: userRate.episodes ?? 0,
            maxValue: max,
            rewatchesValue: userRate.rewatches ?? 0
        )
    }
    
    private func configureStepperValues(status: String, currentValue: Int, maxValue: Int, rewatchesValue: Int) {
        switch status {
        case RatesTypeItemEnum.completed.rawValue:
            stepperView.configure(value: maxValue)
        case RatesTypeItemEnum.planned.rawValue:
            stepperView.configure(value: 0)
        case RatesTypeItemEnum.rewatching.rawValue:
            stepperView.configure(value: rewatchesValue)
        default:
            stepperView.configure(value: currentValue)
        }
    }
    
    private func configureButton() {
        button.addTarget(nil, action: #selector(listTypesSelectTapped), for: .touchUpInside)
        guard let userRate = content.userRate, let status = Constants.watchingStatuses[userRate.status] else { return }
        button.configurate(text: status, image: AppImage.NavigationsBarIcons.chevronDown)
        button.backgroundColor = AppColor.backgroundMinor
        button.titleLabel.textColor = AppColor.textMain
    }
    
    private func configureUI() {
        titleLabel.text = content.title
        descriptionLabel.text = content.description
        if descriptionLabel.text == Texts.Empty.noDescription {
            descriptionLabel.textColor = AppColor.textMinor
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        let tableViewHeight = CGFloat(genreTableView.numberOfRows(inSection: 0)) * inset
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Insets.sideInset),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.sideInset),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Insets.sideInset),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Insets.sideInset),
            
            itemInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            itemInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            itemInfoView.widthAnchor.constraint(equalToConstant: infoViewWidth),
            
            button.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            
            userRateStackView.topAnchor.constraint(
                equalTo: itemInfoView.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            userRateStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            userRateStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(
                equalTo: userRateStackView.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            genreTableView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: tableViewHeight == 0 ? 0 : Constants.Insets.sideInset
            ),
            genreTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            genreTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            genreTableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: genreTableView.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -inset)
        ])
    }
    
    private func configureListTableView() {
        listTableView.didSelectRowHandler = { [weak self] value in
            guard let self else { return }
            if value == Texts.ButtonTitles.removeFromList {
                self.button.configurate(text: Texts.ButtonTitles.addToList, image: AppImage.OtherIcons.addToList)
                self.button.backgroundColor = AppColor.accent
                self.button.titleLabel.textColor = AppColor.textInvert
                self.content.userRate = nil
                self.stepperView.isHidden = true
            } else {
                var newValues = RatesTypeItemEnum.allCases.map { $0.getString() }
                newValues.removeFirst()
                if let status = Constants.watchingStatuses.first(where: { $1 == value })?.key {
                    self.content.configureUserRate(content: self.content, status: status)
                    self.configureStepper()
                }
                newValues.append(Texts.ButtonTitles.removeFromList)
                self.listTableView.configureValues(newValues)
                
                self.button.configurate(text: value, image: AppImage.NavigationsBarIcons.chevronDown)
                self.button.backgroundColor = AppColor.backgroundMinor
                self.button.titleLabel.textColor = AppColor.textMain
            }
            let frame = self.convert(self.button.frame, toView: self.userRateStackView)
            self.removeTransparentView(frame: frame)
        }
    }
    
    private func configureTransparentView() {
        let window = UIApplication.firstKeyWindowForConnectedScenes
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTapped))
        
        transparentView.frame = window?.frame ?? self.frame
        transparentView.backgroundColor = AppColor.backgroundMinor
        transparentView.alpha = 0
        transparentView.addGestureRecognizer(tapGesture)
        addSubview(transparentView)
    }
    
    private func addTransparentView(frame: CGRect) {
        let listMaxHeight: CGFloat = 268.0
        configureTransparentView()
        
        listTableView.frame = CGRect(
            x: frame.origin.x,
            y: frame.origin.y + frame.height,
            width: frame.width,
            height: 0
        )
        addSubview(listTableView)
        listTableView.reloadData()
        
        let height: CGFloat = CGFloat(listTableView.valuesCount) * Constants.Insets.controlHeight
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0.5
                self.listTableView.frame = CGRect(
                    x: frame.origin.x,
                    y: frame.origin.y + frame.height + Constants.Spacing.small,
                    width: frame.width,
                    height: height < listMaxHeight ? height : listMaxHeight
                )
            }
        )
    }
    
    private func removeTransparentView(frame: CGRect) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0
                self.listTableView.frame = CGRect(
                    x: frame.origin.x,
                    y: frame.origin.y + frame.height + Constants.Spacing.small,
                    width: frame.width,
                    height: 0
                )
                self.layoutIfNeeded()
                self.frame = CGRect(
                    x: .zero,
                    y: .zero,
                    width: frame.width,
                    height: self.bounds.height
                )
            }
        )
    }
    
    private func convert(_ frame: CGRect, toView view: UIView) -> CGRect {
        let convertedOrigin = convert(frame.origin, from: view)
        return CGRect(origin: convertedOrigin, size: frame.size)
    }
    
    @objc private func listTypesSelectTapped() {
        configureListTableView()
        buttonTapHandler?()
        let frame = convert(button.frame, toView: userRateStackView)
        addTransparentView(frame: frame)
    }
    
    @objc private func transparentViewTapped() {
        let frame = convert(button.frame, toView: userRateStackView)
        removeTransparentView(frame: frame)
    }
}
