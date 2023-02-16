//
//  FiltersViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 11.02.2023.
//

import UIKit

class FiltersViewController: UIViewController, FiltersViewInput {
    
    var filters: FiltersModel

    // MARK: - Private properties

    private let viewOutput: FiltersViewOutput
    private let scrollView = UIScrollView()
    private let contentView: FiltersView
    private let footerView: FooterFilterView

    // MARK: - Construction

    init(presenter: FiltersViewOutput, filters: FiltersModel) {
        self.filters = filters
        viewOutput = presenter
        contentView = FiltersView(filtersList: filters)
        footerView = FooterFilterView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.delegate = self
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    // MARK: - Private functions

    private func configureUI() {
        view.backgroundColor = AppColor.backgroundMain
        view.addSubviews([scrollView, footerView])
        scrollView.addSubview(contentView)
        [scrollView, contentView, footerView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        configureConstraints()
    }
    
    private func configureNavBar() {
        title = Texts.NavigationBarTitles.filtersTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        configureLeftBarItem()
    }
    
    private func configureLeftBarItem() {
        let backItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.back,
            style: .plain,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        backItem.tintColor = AppColor.textMain
        navigationItem.leftBarButtonItem = backItem
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - FooterFilterViewDelegate

extension FiltersViewController: FooterFilterViewDelegate {
    func tapResetAllButton() {
        contentView.ratingSelectButton.configurate(text: Texts.FilterPlaceholders.rating, isSelect: false)
        contentView.typeSelectButton.configurate(text: Texts.FilterPlaceholders.type, isSelect: false)
        contentView.statusSelectButton.configurate(text: Texts.FilterPlaceholders.status, isSelect: false)
        contentView.genreSelectButton.configurate(text: Texts.FilterPlaceholders.genre, isSelect: false)
        contentView.seasonSelectButton.configurate(text: Texts.FilterPlaceholders.season, isSelect: false)
        contentView.releaseYearStartSelectButton.configurate(
            text: Texts.FilterPlaceholders.releaseYearStart,
            isSelect: false
        )
        contentView.releaseYearEndSelectButton.configurate(
            text: Texts.FilterPlaceholders.releaseYearEnd,
            isSelect: false
        )
    }
    
    func tapApplyButton() {
        let rating = contentView.ratingSelectButton.titleLabel.text == Texts.FilterPlaceholders.rating
        ? "" : contentView.ratingSelectButton.titleLabel.text
        
        let type = contentView.typeSelectButton.titleLabel.text == Texts.FilterPlaceholders.type
        ? "" : contentView.typeSelectButton.titleLabel.text
       
        let status = contentView.statusSelectButton.titleLabel.text == Texts.FilterPlaceholders.status
        ? "" : contentView.statusSelectButton.titleLabel.text
      
        let genre = contentView.genreSelectButton.titleLabel.text == Texts.FilterPlaceholders.genre
        ? "" : contentView.genreSelectButton.titleLabel.text
      
        let season = contentView.seasonSelectButton.titleLabel.text == Texts.FilterPlaceholders.season
        ? "" : contentView.seasonSelectButton.titleLabel.text
      
        let releaseYearStart = contentView.releaseYearStartSelectButton.titleLabel.text ==
        Texts.FilterPlaceholders.releaseYearStart
        ? "" : contentView.releaseYearStartSelectButton.titleLabel.text
       
        let releaseYearEnd = contentView.releaseYearEndSelectButton.titleLabel.text ==
        Texts.FilterPlaceholders.releaseYearEnd
        ? "" : contentView.releaseYearEndSelectButton.titleLabel.text
  
        let filters: FilterListModel = FilterListModel(
            ratingList: rating ?? "",
            typeList: type ?? "",
            statusList: status ?? "",
            genreList: genre ?? "",
            seasonList: season ?? "",
            releaseYearStart: releaseYearStart ?? "",
            releaseYearEnd: releaseYearEnd ?? ""
        )
        
        viewOutput.getFilterList(filters: filters)
    }
}
