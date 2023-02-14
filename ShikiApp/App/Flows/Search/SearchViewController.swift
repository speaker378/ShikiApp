//
//  SearchViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class SearchViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRightBarItem() // удалить, когда появиться экран с поиском
    }
    
}

// TODO: - Для перехода на экрна фильты  Удалитть, когда появиться кнопка

extension SearchViewController {
    private func configureRightBarItem() {
        let shareItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.options,
            style: .plain,
            target: self,
            action: #selector(filtersButtonTapped)
        )
        shareItem.tintColor = AppColor.textMain
        navigationItem.rightBarButtonItem = shareItem
    }
    
    @objc private func filtersButtonTapped() {
        let filtersViewController = FiltersBuilder.build(filters: FiltersModelFactory().filtersList)
        navigationController?.pushViewController(filtersViewController, animated: true)
    }
}
