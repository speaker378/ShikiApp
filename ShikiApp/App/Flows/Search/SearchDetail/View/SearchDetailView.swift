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
    private let stepperView: StepperView = {
        let stepper = StepperView(title: Texts.DetailLabels.episodes)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    private let userRateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Spacing.medium
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    private let listTableView: ListTableView = {
        let tableView = ListTableView(values: [])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let ratingView: ScoringView
    private(set) var content: SearchDetailModel
    private var buttonTapHandler: (() -> Void)?

    // MARK: - Construction
    
    init(content: SearchDetailModel) {
        self.content = content
        itemInfoView = ItemInfoView(content: content)
        genreTableView = ChipsTableView(values: content.genres)
        let score = Int(Double(content.userRate?.score.value ?? "") ?? 0.0)
        print( "@@@@ rating = \(score)")
        ratingView = ScoringView(score: score)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func configureUserList(
        listType: RatesTypeItemEnum,
        score: Score? = nil,
        episodes: Int? = nil,
        rewatches: Int? = nil,
        chapters: Int? = nil,
        volumes: Int? = nil
    ) {
        button.configurate(text: listType.getString(), image: AppImage.NavigationsBarIcons.chevronDown)
        content.configureUserRate(
            content: content,
            status: listType.rawValue,
            episodes: episodes,
            rewatches: rewatches,
            chapters: chapters,
            volumes: volumes
        )
    }

    // MARK: - Private functions
    
    private func configure() {
        stepperView.delegate = self
        stepperView.dataSource = self
        addSubview(scrollView)
        configureButton()
        configureStepper()
        let rateList = makeRatesList(status: content.status, userRates: content.userRate)
        listTableView.configureValues(rateList)
        [button, stepperView, ratingView].forEach { userRateStackView.addArrangedSubview($0) }
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
        
        updateStepperValues(
            status: userRate.status,
            currentValue: stepperViewCurrentValue(stepperView),
            maxValue: stepperViewMaximumValue(stepperView),
            rewatchesValue: userRate.rewatches ?? 0
        )
    }
    
    private func updateStepperValues(status: String, currentValue: Int, maxValue: Int?, rewatchesValue: Int) {
        switch status {
        case RatesTypeItemEnum.completed.rawValue:
            stepperView.configure(value: maxValue ?? currentValue)
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
                AddedToListData.shared.remove(self.content)
            } else {
                if let status = RatesTypeItemEnum(status: value) {
                    self.configureUserList(listType: status)
                    self.configureStepper()
                }
                let newValues = self.makeRatesList(status: self.content.status, userRates: self.content.userRate)
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
    
    /// подготовка значений для выпадающего списка к кнопке "Добавить в список"
    private func makeRatesList(status: String, userRates: UserRatesModel?) -> [String] {
        if status == Constants.mangaStatusDictionary["anons"] || status == Constants.animeStatusDictionary["anons"] {
            return [RatesTypeItemEnum.planned.getString(), Texts.ButtonTitles.removeFromList]
        }
        var array = RatesTypeItemEnum.allCases.map { $0.getString() }
        array.removeFirst()
        if userRates != nil {
            array.append(Texts.ButtonTitles.removeFromList)
        }
        return array
    }
    
    @objc private func listTypesSelectTapped() {
        configureListTableView()
        let frame = convert(button.frame, toView: userRateStackView)
        addTransparentView(frame: frame)
    }
    
    @objc private func transparentViewTapped() {
        let frame = convert(button.frame, toView: userRateStackView)
        removeTransparentView(frame: frame)
    }
}
