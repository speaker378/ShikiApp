//
//  ProfilePresenter.swift
//  ShikiApp
//
//  Created by Anton Lebedev on 02.02.2023.
//  As per https://www.youtube.com/watch?v=2z5uWBRGjFI

import UIKit

protocol ProfileViewInputProtocol: AnyObject {
    var model: UserProfileDTO? { get set }
}

protocol ProfileViewOutputProtocol: AnyObject {
    func viewDidSelectUser(user: UserProfileDTO)
    func fetchData()
}

final class ProfilePresenter: ProfileViewOutputProtocol {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & ProfileViewInputProtocol)?

    // MARK: - Private properties
    
    private var user: UserModelAPI {
        return USERMODEL
    }

    // MARK: - Functions
    
    func viewDidSelectUser(user: UserProfileDTO) {
        let profileViewController = ProfileBuilder.build()
        viewInput?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func fetchData() {
        
    }
}
