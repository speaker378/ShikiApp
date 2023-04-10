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
    func createUserRates(content: SearchDetailModel)
    func updateUserRate(userRate: UserRatesModel)
    func removeUserRate(userRateID: Int)
}

final class SearchDetailPresenter: SearchDetailViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & SearchDetailViewInput)?
    
    // MARK: Private properties
    
    private var provider: any ContentProviderProtocol
    private var userRatesManager: any UserRatesManagerProtocol

    // MARK: - Constructors
    
    init(provider: any ContentProviderProtocol) {
        self.provider = provider
        self.userRatesManager = UserRatesManager()
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
    
    func createUserRates(content: SearchDetailModel) {
        guard let userRate = content.userRate else { return }
        userRatesManager.createUserRate(userRate: userRate) { [weak self] error in
            self?.viewInput?.showAlert(title: Texts.ErrorMessage.error, message: error)
        }
    }
    
    func updateUserRate(userRate: UserRatesModel) {
        userRatesManager.updateUserRate(userRate: userRate) { [weak self] error in
            self?.viewInput?.showAlert(title: Texts.ErrorMessage.error, message: error)
        }
    }
    
    func removeUserRate(userRateID: Int) {
        userRatesManager.removeUserRate(userRateID: userRateID) { [weak self] error in
            self?.viewInput?.showAlert(title: Texts.ErrorMessage.error, message: error)
        }
    }
}
