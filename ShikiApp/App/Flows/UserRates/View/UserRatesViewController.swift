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

extension UserRatesViewController: UserRatesViewDlegate {
    func statusValueChanged(status: String) {
        self.viewOutput.statusValueChanged(status: status)
    }
    
    func viewDidSelectEntity(entity: UserRatesModel) {
        self.viewOutput.viewDidSelectEntity(entity: entity)
    }
    
    func changeSegmentedValueChanged(index: Int) {
        self.viewOutput.changeSegmentedValueChanged(index: index)
    }
}
