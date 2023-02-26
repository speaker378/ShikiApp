//
//  SeatchDetailPresenter.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

protocol SearchDetailViewInput: AnyObject {
    func showAlert(title: String, message: String?)
}

protocol SearchDetailViewOutput: AnyObject {
    func fetchData(id: Int, completion: @escaping (SearchDetailModel) -> Void)
}

final class SearchDetailPresenter: SearchDetailViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & SearchDetailViewInput)?
    
    // MARK: Private properties
    
    private var provider: any ContentProviderProtocol

    // MARK: - Constructors
    
    init(provider: any ContentProviderProtocol) {
        self.provider = provider
    }

    // MARK: - Functions

    func fetchData(id: Int, completion: @escaping (SearchDetailModel) -> Void) {
        provider.fetchDetailData(id: id, completion: { [weak self] response, error in
            guard let response else {
                self?.viewInput?.showAlert(title: Texts.ErrorMessage.failLoading, message: error)
                return
            }
            let content = SearchDetailModelFactory().makeDetailModel(from: response)
            completion(content)
        })
    }
}
