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
    func changeSegmentedValueChanged(index: Int)
    func statusValueChanged(status: String)
}

final class UserRatesPresenter: UserRatesViewOutput {

    // MARK: - Properties

    weak var viewInput: (UIViewController & UserRatesViewInput)?

    // MARK: - Functions

    func viewDidSelectEntity(entity: UserRatesModel) {
        print("Entity details screen build will be done here\n \(entity)")
    }
    
    func changeSegmentedValueChanged(index: Int) {
        print("selector \(index)")
     
    }
    
    func statusValueChanged(status: String) {
        print("status \(status)")
    }
}
