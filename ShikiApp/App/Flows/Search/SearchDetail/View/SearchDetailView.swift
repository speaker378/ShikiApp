//
//  SearchDetailView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

final class SearchDetailView: UIView {

    // MARK: - Properties
    
    var userRatesDidRemovedCompletion: ((SearchDetailModel) -> Void)?
    var userRatesDidChangedCompletion: ((SearchDetailModel) -> Void)?

    // MARK: - Private properties

    private let inset: CGFloat = 24.0
    private let regularInset: CGFloat = 16.0
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
    private(set) var scoringView: ScoringView
    private(set) var content: SearchDetailModel
    private let listTableView: ListTableView
    private var screenshotCollection: TitledCollectionView
    private let videoCollection: TitledCollectionView
    private var buttonTapHandler: (() -> Void)?

    // MARK: - Constructions
    
    init(
        content: SearchDetailModel,
        itemTapCompletion: ((String) -> Void)? = nil,
        tapHandler: @escaping () -> Void
    ) {
        itemInfoView = ItemInfoView(content: content)
        genreTableView = ChipsTableView(values: content.genres)
        scoringView = ScoringView(score: Int(Double(content.userRate?.score.value ?? "") ?? 0.0))
        listTableView = ListTableView(values: content.rateList)
        screenshotCollection = TitledCollectionView(
            title: Texts.ContentTitles.screenshots,
            imageURLStrings: content.screenshots ?? [],
            itemTapCompletion: itemTapCompletion
        )
        videoCollection = TitledCollectionView(
            title: Texts.ContentTitles.videos,
            imageURLStrings: content.videos?.compactMap {$0.url} ?? [],
            imageComments: content.videos?.filter {$0.url != nil}.map {$0.name},
            itemTapCompletion: itemTapCompletion
        )
        buttonTapHandler = tapHandler
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func updateUserRate(status: RatesTypeItemEnum, score: Score? = nil) {
        if status == .rewatching {
            content.configureUserRate(status: status.rawValue, score: score, rewatches: stepperView.value)
        } else if content.type == UserRatesTargetType.anime.rawValue {
            content.configureUserRate(status: status.rawValue, score: score, episodes: stepperView.value)
        } else if content.type == UserRatesTargetType.manga.rawValue {
            content.configureUserRate(status: status.rawValue, score: score, chapters: stepperView.value)
        }
        
        button.configurate(text: status.getString(), image: AppImage.NavigationsBarIcons.chevronDown)
        userRatesDidChangedCompletion?(content)
    }

    // MARK: - Private functions
    
    private func configure() {
        stepperView.delegate = self
        stepperView.dataSource = self
        configureStepper()
        configureButton()
        configureScoring()
        button.addTarget(nil, action: #selector(listTypesSelectTapped), for: .touchUpInside)
        listTableView.configureValues(makeRatesList(status: content.status, userRates: content.userRate))
        configureUI()
        
        scoringView.didChangedValueCompletion = { [weak self] score in
            guard
                let self,
                let color = Constants.scoreColors[String(score)],
                let status = RatesTypeItemEnum(rawValue: self.content.userRate?.status ?? "")
                else { return }
            let score = Score(value: String(score), color: color)
            self.updateUserRate(status: status, score: score)
        }
    }
    
    private func configureUI() {
        addSubview(scrollView)
        configureButton(with: content)
        [button, stepperView, scoringView].forEach {
            userRateStackView.addArrangedSubview($0)
        }
        scrollView.addSubviews([itemInfoView, userRateStackView, titleLabel, genreTableView, descriptionLabel,
            screenshotCollection,
            videoCollection])
        [itemInfoView, genreTableView,
         screenshotCollection, videoCollection].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureButton(with: content)
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
            descriptionLabel.bottomAnchor.constraint(equalTo: screenshotCollection.topAnchor, constant: -regularInset),
            screenshotCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            screenshotCollection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            screenshotCollection.bottomAnchor.constraint(equalTo: videoCollection.topAnchor, constant: -regularInset),
            videoCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            videoCollection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            videoCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -inset)
            
            
        ])

    }
    
    private func configureScoring() {
        guard content.userRate != nil else {
            scoringView.isHidden = true
            return
        }
        if let episodes = content.userRate?.episodes, episodes > 0 {
            scoringView.isHidden = false
        } else if let chapters = content.userRate?.chapters, chapters > 0 {
            scoringView.isHidden = false
        } else {
            scoringView.isHidden = true
        }
    }
    
    private func configureStepper() {
        guard let userRate = content.userRate else {
            stepperView.isHidden = true
            return
        }
        stepperView.isHidden = false
        updateStepperValue(status: userRate.status)
    }
    
    private func updateStepperValue(status: String) {
        var value = stepperView.value
        switch status {
        case RatesTypeItemEnum.completed.rawValue:
            value = stepperView.maximumValue ?? stepperView.value
        case RatesTypeItemEnum.planned.rawValue:
            value = 0
        case RatesTypeItemEnum.rewatching.rawValue:
            value = stepperView.value
        default:
            value = stepperView.value
        }
        
        stepperView.configure(value: value)
    }
    
    private func configureButton() {
        if let userRate = content.userRate, let status = RatesTypeItemEnum(rawValue: userRate.status)?.getString() {
            button.configurate(text: status, image: AppImage.NavigationsBarIcons.chevronDown)
            button.backgroundColor = AppColor.backgroundMinor
            button.titleLabel.textColor = AppColor.textMain
        } else {
            button.configurate(text: Texts.ButtonTitles.addToList, image: AppImage.OtherIcons.addToList)
            button.backgroundColor = AppColor.accent
            button.titleLabel.textColor = AppColor.textInvert
        }
    }
    
    private func configureListTableView() {
        listTableView.didSelectRowHandler = { [weak self] value in
            guard let self else { return }
            if value == Texts.ButtonTitles.removeFromList {
                self.content.userRate = nil
                self.userRatesDidRemovedCompletion?(self.content)
            } else {
                if let status = RatesTypeItemEnum(status: value) {
                    self.updateStepperValue(status: status.rawValue)
                    self.updateUserRate(status: status)
                }
                let newValues = self.makeRatesList(status: self.content.status, userRates: self.content.userRate)
                self.listTableView.configureValues(newValues)
            }
            self.configureStepper()
            self.configureButton()
            self.configureScoring()
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
