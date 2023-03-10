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
    private var buttonTapHandler: (() -> Void)?

    // MARK: - Construction
    
    init(content: SearchDetailModel, tapHandler: @escaping () -> Void) {
        itemInfoView = ItemInfoView(content: content)
        genreTableView = ChipsTableView(values: content.genres)
        listTableView = ListTableView(values: content.rateList)
        buttonTapHandler = tapHandler
        super.init(frame: .zero)
        configure(with: content)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure(with content: SearchDetailModel) {
        addSubview(scrollView)
        configureButton(with: content)
        scrollView.addSubviews([itemInfoView, button, titleLabel, genreTableView, descriptionLabel])
        [itemInfoView, genreTableView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        genreTableView.reloadData()
        configureUI(with: content)
    }
    
    private func configureButton(with content: SearchDetailModel) {
        button.addTarget(nil, action: #selector(listTypesSelectTapped), for: .touchUpInside)
        guard let userRate = content.userRate, let status = Constants.watchingStatuses[userRate.status] else { return }
        button.configurate(text: status, image: AppImage.NavigationsBarIcons.chevronDown)
        button.backgroundColor = AppColor.backgroundMinor
        button.titleLabel.textColor = AppColor.textMain
    }
    
    private func configureUI(with content: SearchDetailModel) {
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
            
            button.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: Constants.Insets.sideInset),
            button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),
            
            titleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: Constants.Insets.sideInset),
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
        let frame = convert(button.frame, toView: scrollView)
        listTableView.didSelectRowHandler = { [weak self] value in
            guard let self else { return }
            if value == Texts.ButtonTitles.removeFromList {
                self.button.configurate(text: Texts.ButtonTitles.addToList, image: AppImage.OtherIcons.addToList)
                self.button.backgroundColor = AppColor.accent
                self.button.titleLabel.textColor = AppColor.textInvert
                self.removeTransparentView(frame: frame)
            } else {
                self.button.configurate(text: value, image: AppImage.NavigationsBarIcons.chevronDown)
                self.button.backgroundColor = AppColor.backgroundMinor
                self.button.titleLabel.textColor = AppColor.textMain
                self.removeTransparentView(frame: frame)
            }
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
    
    private func convert(_ frame: CGRect, toView: UIView) -> CGRect {
        let convertedOrigin = convert(frame.origin, from: scrollView)
        return CGRect(origin: convertedOrigin, size: frame.size)
    }
    
    @objc private func listTypesSelectTapped() {
        configureListTableView()
        buttonTapHandler?()
        let frame = convert(button.frame, toView: scrollView)
        addTransparentView(frame: frame)
    }
    
    @objc private func transparentViewTapped() {
        let frame = convert(button.frame, toView: scrollView)
        removeTransparentView(frame: frame)
    }
}
