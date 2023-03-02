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
    private let button: ButtonWithIconView = {
        let button = ButtonWithIconView(title: Texts.ButtonTitles.addToList, icon: AppImage.OtherIcons.addToList)
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

    // MARK: - Construction
    
    init(content: SearchDetailModel, tapHandler: @escaping () -> Void) {
        itemInfoView = ItemInfoView(content: content)
        genreTableView = ChipsTableView(values: content.genres)
        button.tapHandler = tapHandler
        super.init(frame: .zero)
        configure(with: content)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure(with content: SearchDetailModel) {
        addSubview(scrollView)
        scrollView.addSubviews([itemInfoView, button, titleLabel, genreTableView, descriptionLabel])
        [itemInfoView, genreTableView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        titleLabel.text = content.title
        descriptionLabel.text = content.description
        if descriptionLabel.text == Texts.Empty.noDescription {
            descriptionLabel.textColor = AppColor.textMinor
        }
        genreTableView.reloadData()
        
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
}
