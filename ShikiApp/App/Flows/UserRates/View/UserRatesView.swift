//
//  UserRatesView.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

protocol UserRatesViewDlegate: AnyObject {
    func changeSegmentedValueChanged(index: Int)
    func viewDidSelectEntity(entity: UserRatesModel)
    func statusValueChanged(status: String)
}

class UserRatesView: UIView {

    // MARK: - Properties

    var model: [UserRatesModel]
    
    var filteredModel: [UserRatesModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.ratesTableView.reloadData()
            }
        }
    }
    
    var index: Int = 0

    weak var delegate: UserRatesViewDlegate?
    
    
    var selectedButton = SelectedButton()
    var dataSource = [String]()
    var listTypes = RatesTypeItemEnum.allCases.map {$0.getString()}
    let transparentView = UIView()
    let selectTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = Constants.CornerRadius.medium
        tableView.backgroundColor = AppColor.backgroundMain
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    let ratesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Private properties

    private let ratesTableViewHeight: CGFloat =
    UIScreen.main.bounds.height -
    (Constants.Insets.sideInset * 3 +
     ControlConstants.Properties.segmentHeight +
     Constants.Insets.controlHeight
    )
    
    private(set) lazy var segmentControl: CustomSegmentControl = {
        let control = CustomSegmentControl(items: [SearchContentEnum.anime.rawValue, SearchContentEnum.manga.rawValue])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return control
    }()
    
    private(set) lazy var listTypesSelectButton: SelectedButton = {
        let button = SelectedButton()
        button.configurate(text: Texts.FilterPlaceholders.all, isSelect: false)
        button.titleLabel.font = AppFont.Style.blockTitle
        button.addTarget(self, action: #selector(listTypesSelectTapped), for: .touchUpInside)
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.backgroundColor =  AppColor.backgroundMinor
        return view
    }()

    // MARK: - Construction

    init(model: [UserRatesModel]) {
        self.model = model
        super.init(frame: .zero)
        selectTableView.delegate = self
        selectTableView.dataSource = self
        ratesTableView.delegate = self
        ratesTableView.dataSource = self
        selectTableView.registerCell(MenuItemsListTableViewCell.self)
        ratesTableView.registerCell(UserRatesTableViewCell.self)
        selectedButton.titleLabel.text = Texts.ListTypesSelectItems.all
        filterModelBySegmentControl(index: index)
        configureUI()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions

    func filterModelByTypesSelect(status: String) {
       filterModelBySegmentControl(index: index)
       if status != Texts.ListTypesSelectItems.all {
           filteredModel = filteredModel.filter {$0.status == status}
       }
   }

    // MARK: - Private functions

    private func filterModelBySegmentControl(index: Int) {
        if index == 0 {
           filteredModel = model.filter {$0.target == "Anime"}
        } else {
            filteredModel = model.filter {$0.target == "Manga"}
        }
    }
    
    private func configureUI() {
        [ segmentControl,
          listTypesSelectButton,
          separatorView,
          selectTableView,
          ratesTableView
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.Insets.sideInset
            ),
            segmentControl.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.sideInset
            ),
            segmentControl.heightAnchor.constraint(equalToConstant: ControlConstants.Properties.segmentHeight),
            segmentControl.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.sideInset
            ),
            listTypesSelectButton.topAnchor.constraint(
                equalTo: segmentControl.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            listTypesSelectButton.leftAnchor.constraint(equalTo: segmentControl.leftAnchor),
            listTypesSelectButton.rightAnchor.constraint(equalTo: segmentControl.rightAnchor),
            listTypesSelectButton.heightAnchor.constraint(equalToConstant: Constants.Insets.controlHeight),

            ratesTableView.topAnchor.constraint(
                equalTo: listTypesSelectButton.bottomAnchor,
                constant: Constants.Insets.sideInset
            ),
            ratesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ratesTableView.heightAnchor.constraint(equalToConstant: ratesTableViewHeight)
        ])
    }
    
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        filterModelBySegmentControl(index: index)
        filterModelByTypesSelect(status: selectedButton.titleLabel.text ?? Texts.ListTypesSelectItems.all)
        delegate?.changeSegmentedValueChanged(index: index)
    }
    
    @objc private func listTypesSelectTapped() {
        dataSource = listTypes.filter { $0 != selectedButton.titleLabel.text ?? "" }
        selectedButton = listTypesSelectButton
        addTransparentView(frames: listTypesSelectButton.frame)
    }
}
