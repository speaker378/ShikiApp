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
    private let errorView: ErrorView  = {
        let errorView = ErrorView(image: AppImage.ErrorsIcons.otherError, text: Texts.ErrorMessage.failLoading)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    private var contentView: SearchDetailView?
    private var content: SearchDetailModel?

    // MARK: - Construction
    
    init(presenter: SearchDetailViewOutput, id: Int) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        errorView.isHidden = true
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
    
    func showErrorView(text: String) {
        errorView.configure(text: text)
        errorView.isHidden = false
        activityIndicator.stopAnimating()
    }

    // MARK: - Private functions
    
    private func configure(with id: Int) {
        presenter.fetchData(id: id) { [weak self] content in
            guard let self else { return }
            self.activityIndicator.stopAnimating()
            self.content = content
            self.title = content.title
            self.contentView = SearchDetailView(content: content, itemTapCompletion: self.presenter.showImage)
            self.configureContentView()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = AppColor.backgroundMain
        view.addSubviews([activityIndicator, errorView])
        activityIndicator.startAnimating()
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureContentView() {
        guard let contentView else { return }
        view.addSubview(contentView)
        contentView.userRatesDidCreatedCompletion = { [weak self] content in
            self?.presenter.createUserRates(content: content)
        }
        contentView.userRatesDidRemovedCompletion = { [weak self] content in
            guard let userRateID = content.userRate?.userRateID else { return }
            self?.presenter.removeUserRate(userRateID: userRateID)
            content.userRate = nil
        }
        contentView.userRatesDidChangedCompletion = { [weak self] content in
            guard let userRate = content.userRate else { return }
            self?.presenter.updateUserRate(userRate: userRate)
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureNavBar() {
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
}
