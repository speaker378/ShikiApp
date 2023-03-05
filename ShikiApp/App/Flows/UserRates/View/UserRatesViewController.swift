//
//  UserRatesViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class UserRatesViewController: UIViewController, UserRatesViewInput {

    var model: [UserRatesModel] = UserRatesModelFactoryMoсk().userRatesModelFactoryMoсk {
        didSet {
            DispatchQueue.main.async {
                self.contentView.ratesTableView.reloadData()
            }
        }
    }

    // MARK: - Private properties

    private let viewOutput: UserRatesViewOutput
    private let scrollView = UIScrollView()
    private var contentView: UserRatesView

    // MARK: - Construction

    init(presenter: UserRatesViewOutput) {
        viewOutput = presenter
        contentView = UserRatesView(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
 
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        configureUI()
        viewOutput.getRatesList(targetType: .anime,  status: nil)
    }

    // MARK: - Private functions

    private func configureUI() {
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [scrollView, contentView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}

extension UserRatesViewController: UserRatesViewDelegate {
    func statusValueChanged(status: String) {
        let statusEnum = RatesTypeItemEnum.self
        if status == statusEnum.all.getString() {
            viewOutput.status = nil
        } else if status == statusEnum.completed.getString() {
            viewOutput.status = .completed
        } else if status == statusEnum.dropped.getString() {
            viewOutput.status = .dropped
        } else if status == statusEnum.onHold.getString() {
            viewOutput.status = .onHold
        } else if status == statusEnum.planned.getString() {
            viewOutput.status = .planned
        } else if status == statusEnum.rewatching.getString() {
            viewOutput.status = .reWatching
        } else if status == statusEnum.watching.getString() {
            viewOutput.status = .watching
        }
        
        self.viewOutput.statusValueChanged()
    }
    
    func viewDidSelectEntity(entity: UserRatesModel) {
        self.viewOutput.viewDidSelectEntity(entity: entity)
    }
    
    func changeSegmentedValueChanged(index: Int) {
        if index == 0 {
            viewOutput.targetType = .anime
        } else if index == 1 {
            viewOutput.targetType = .manga
        }
        
        self.viewOutput.changeSegmentedValueChanged()
    }
}
