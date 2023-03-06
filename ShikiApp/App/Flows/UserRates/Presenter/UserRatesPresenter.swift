//
//  UserRatesPresenter.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

protocol UserRatesViewInput: AnyObject {
    var model: [UserRatesModel] { get set }
}

protocol UserRatesViewOutput: AnyObject {
    func viewDidSelectEntity(entity: UserRatesModel)
    func changeSegmentedValueChanged()
    func statusValueChanged()
    func getRatesList(targetType: UserRatesTargetType, status: UserRatesStatus?)
   
    var targetType: UserRatesTargetType { get set }
    var status: UserRatesStatus? { get set }
    var error: String { get set }
}

final class UserRatesPresenter: UserRatesViewOutput {

    // MARK: - Properties

    weak var viewInput: (UIViewController & UserRatesViewInput)?
    private var ratesList: UserRatesResponseDTO = []
    
    var targetType: UserRatesTargetType = .anime
    var status: UserRatesStatus?
    var error: String = ""

    // MARK: - Functions

    func viewDidSelectEntity(entity: UserRatesModel) {
        print("Entity details screen build will be done here\n \(entity)")
    }
    
    func changeSegmentedValueChanged() {
        getRatesList(targetType: targetType, status: status)
    }
    
    func statusValueChanged() {
        getRatesList(targetType: targetType, status: status)
    }
    
    func getRatesList(targetType: UserRatesTargetType, status: UserRatesStatus?) {
        
        let factory = ApiFactory.makeUserRatesApi()
        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let userId = user?.id {
                factory.getList(
                    userId: userId,
                    targetType: targetType,
                    status: status
                ) { data, errorString in
                    if let data {
                        self.ratesList = data
                        self.error = errorString ?? ""
                        print(self.ratesList)
                    }
                }
            }
        }
    }
    
}
