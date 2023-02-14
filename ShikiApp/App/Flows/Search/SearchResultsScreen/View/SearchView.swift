//
//  SearchView.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import UIKit

// MARK: - SearchViewDelegate

protocol SearchViewDelegate: AnyObject {
    
    func onContentTypeChanged(index: Int)
    func onFilterButtonTap()
}

// MARK: - SearchView

class SearchView: UIView {

    // MARK: - Properties

    var delegate: (SearchViewDelegate & UITableViewDataSource & UITableViewDelegate & UITextFieldDelegate)?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let resultsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.openSansFont(ofSize: 20, weight: .bold)
        label.backgroundColor = AppColor.backgroundMain
        label.textColor = AppColor.textMain
        label.textAlignment = .left
        return label
    }()
    
    let searchTextField: BorderedTextField = {
        let textField = BorderedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.keyboardType = .default
        textField.keyboardAppearance = .light
        return textField
    }()
    
    let mainBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.ErrorsIcons.noResults
        imageView.isHidden = true
        return imageView
    }()

    var backgroundLabel: UILabel = {
        let label = AppLabel(
            alignment: .center,
            fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
            fontСolor: AppColor.textMinor,
            numberLines: 0
        )
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Texts.ErrorMessage.noResults
        return label
    }()

    let button: CounterButton = {
        let control = CounterButton()
            .setImageColor(color: AppColor.textMain)
            .setCounterColor(color: AppColor.accent)
            .setImage(image: ControlConstants.sliderImage)
            .setCounter(counter: 0)
        control.layer.cornerRadius = ControlConstants.Properties.searchRadius
        control.layer.backgroundColor = AppColor.backgroundMinor.cgColor
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    // MARK: - Private Properties

    private let searchBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = ControlConstants.Properties.searchRadius
        view.backgroundColor = AppColor.backgroundMinor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()

    private let segmentControl: CustomSegmentControl = {
        let control = CustomSegmentControl(items: SearchContentEnum.allCases.map { $0.rawValue })
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private var topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        delegate?.onContentTypeChanged(index: sender.selectedSegmentIndex )
    }

    @objc private func pressFilterButton(_: Any!) {
        delegate?.onFilterButtonTap()
    }

    private func setupViews() {
        searchBackground.addSubviews(button, searchTextField)
        mainBackgroundView.addSubviews(backgroundImageView, backgroundLabel)
        tableView.backgroundView = mainBackgroundView
        topBackgroundView.addSubviews(segmentControl, searchBackground, resultsTitle)
        addSubviews(tableView, topBackgroundView)
        configureUI()
    }

    private func configureUI() {
        setupConstraints()
        tableView.registerCell(SearchTableCell.self)
        configureControls()
    }

    private func configureControls() {
        button.addTarget(self, action: #selector(pressFilterButton), for: .touchUpInside)
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ControlConstants.Properties.segmentTop
            ),
            topBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackgroundView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            segmentControl.topAnchor.constraint(equalTo: topBackgroundView.topAnchor),
            segmentControl.leadingAnchor.constraint(
                equalTo: topBackgroundView.leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            segmentControl.heightAnchor.constraint(equalToConstant: ControlConstants.Properties.segmentHeight),
            segmentControl.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            searchBackground.topAnchor.constraint(
                equalTo: segmentControl.bottomAnchor,
                constant: ControlConstants.Properties.searchTop
            ),
            searchBackground.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor),
            searchBackground.heightAnchor.constraint(equalToConstant: ControlConstants.Properties.searchHeight),
            searchBackground.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor),
            searchTextField.topAnchor.constraint(
                equalTo: searchBackground.topAnchor,
                constant: ControlConstants.Properties.inputVerticalOffset
            ),
            searchTextField.leadingAnchor.constraint(
                equalTo: searchBackground.leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            searchTextField.trailingAnchor.constraint(
                equalTo: searchBackground.trailingAnchor,
                constant: -ControlConstants.Properties.inputRightInset
            ),
            searchTextField.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor),
            button.topAnchor.constraint(equalTo: searchBackground.topAnchor),
            button.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            button.trailingAnchor.constraint(equalTo: searchBackground.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: searchBackground.bottomAnchor)
        ])
        setupTableConstraints()
    }
    
    private func setupTableConstraints() {
        NSLayoutConstraint.activate([
            resultsTitle.topAnchor.constraint(
                equalTo: searchBackground.bottomAnchor,
                constant: ControlConstants.Properties.resultsLabelVerticalOffset
            ),
            resultsTitle.heightAnchor.constraint(equalToConstant: ControlConstants.Properties.tableHeaderHeight),
            resultsTitle.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            resultsTitle.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            tableView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ControlConstants.Properties.tableTop
            ),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(
                equalToConstant: ControlConstants.Properties.backgroundImageSize
            ),
            backgroundImageView.heightAnchor.constraint(
                equalToConstant: ControlConstants.Properties.backgroundImageSize
            ),
            backgroundLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            backgroundLabel.topAnchor.constraint(
                equalTo: backgroundImageView.bottomAnchor, constant: ControlConstants.Properties.backgroundLabelInset
            )
        ])
    }
}
