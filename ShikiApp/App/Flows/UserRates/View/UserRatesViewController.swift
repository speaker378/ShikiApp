//
//  UserRatesViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class UserRatesViewController: UIViewController, UserRatesViewInput {

    var model: [UserRatesModel] = [] {
        didSet {
            activityIndicator.stopAnimating()
            self.contentView.model = self.model
        }
    }

    // MARK: - Private properties

    private let viewOutput: UserRatesViewOutput
    private var isFirstOpening: Bool = true
    
    private let scrollView = UIScrollView()
    private var contentView: UserRatesView
   
  var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        return view
    }()

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstOpening {
            activityIndicator.startAnimating()
            viewOutput.getRatesList(targetType: .anime, status: nil)
            isFirstOpening = false
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        configureUI()
    }

    // MARK: - Functions
    
    @objc func refreshData() {
        scrollView.refreshControl?.beginRefreshing()
        activityIndicator.startAnimating()
        viewOutput.updateData { [weak self] in
            guard let self else { return }
            self.scrollView.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Private functions

    private func configureUI() {
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(scrollView)
        scrollView.addSubviews([contentView, activityIndicator])
        [scrollView, contentView, activityIndicator].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        configureConstraints()
        setupPullToRefresh()
    }
    
    private func setupPullToRefresh() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.attributedTitle = NSAttributedString(string: Texts.LoadingMessage.inProgress)
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
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
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
}

// MARK: - UserRatesViewDelegate

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
        activityIndicator.startAnimating()
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
        activityIndicator.startAnimating()
    }
}
