//
//  SearchDetailViewController.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

final class SearchDetailViewController: UIViewController, SearchDetailViewInput {

    // MARK: - Private properties
    
    private let presenter: SearchDetailViewOutput
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        return view
    }()
    private var contentView: SearchDetailView?
    private var content: SearchDetailModel?

    // MARK: - Construction
    
    init(presenter: SearchDetailViewOutput, id: Int) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        configure(with: id)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    // MARK: - Functions
    
    func showAlert(title: String, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Texts.ButtonTitles.close, style: .default))
        present(alertController, animated: true)
        activityIndicator.stopAnimating()
    }

    // MARK: - Private functions
    
    private func configure(with id: Int) {
        presenter.fetchData(id: id) { [weak self] content in
            guard let self else { return }
            self.activityIndicator.stopAnimating()
            self.content = content
            self.title = content.title
            self.contentView = SearchDetailView(content: content)
            self.configureContentView()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    private func configureContentView() {
        guard let contentView else { return }
        view.addSubview(contentView)
        contentView.userRatesDidCreatedCompletion = { [weak self] content in
            AddedToListData.shared.add(content)
            self?.presenter.createUserRates(content: content)
        }
        contentView.userRatesDidRemovedCompletion = { [weak self] content in
            guard let userRateID = content.userRate?.userRateID else { return }
            self?.presenter.removeUserRate(userRateID: userRateID)
            AddedToListData.shared.remove(content)
            content.userRate = nil
            print("@@ userRate after removing = \(String(describing: self?.content?.userRate))")
        }
        contentView.userRatesDidChangedCompletion = { [weak self] content in
            AddedToListData.shared.update(content)
            guard let userRate = content.userRate else { return }
            self?.presenter.updateUserRate(userRate: userRate)
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isTranslucent = false
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
}
