//
//  SearchDetailViewController.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

// TODO: - добавить анимацию на загрузку данных

final class SearchDetailViewController: UIViewController, SearchDetailViewInput {

    // MARK: - Private properties
    
    private let presenter: SearchDetailViewOutput
    private let contentView: SearchDetailView

    // MARK: - Construction
    
    init(presenter: SearchDetailViewOutput, content: SearchDetailModel) {
        self.presenter = presenter
        contentView = SearchDetailView(content: content)
        super.init(nibName: nil, bundle: nil)
        title = content.title
    }
    
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    // MARK: - Private functions
    
    private func configureUI() {
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(contentView)
        configureConstraints()
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
    
    private func configureConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
