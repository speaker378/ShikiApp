//
//  ProfilePresenter.swift
//  ShikiApp
//

import UIKit

protocol ProfileViewInputProtocol: AnyObject {
    
    var model: UserViewModel? { get set }
    var isAuth: Bool { get set }
}

protocol ProfileViewOutputProtocol: AnyObject {

    func fetchData()
    func didPressedLogoutButton()
    func isAuth() -> Bool
}

final class ProfilePresenter: ProfileViewOutputProtocol {

    // MARK: - Properties

    weak var viewInput: (UIViewController & ProfileViewInputProtocol)?

    // MARK: - Private properties

    private let apiFactory = ApiFactory.makeUsersApi()
    private let modelFactory = UserModelFactory()
    private var userData: UserDTO?

    // MARK: - Private functions
    
    private func fetchDataFromServer(completion: @escaping () -> Void) {
            apiFactory.whoAmI { [weak self] data, _ in
                guard let data else {
                    return
                }
                self?.userData = data
                completion()
            }
        }

    // MARK: - Functions

    func fetchData() {
        if AuthManager.share.isAuth() == true {
            fetchDataFromServer { [weak self] in
                guard let self else { return }
                self.userData = self.userData
            }
        } else {
            print("User is not logged in")
        }
    }
    
    func didPressedLogoutButton() {
            if isAuth() {
                AuthManager.share.logOut()
                viewInput?.isAuth = false
            } else {
                AuthManager.share.auth { [weak self] result in
                    DispatchQueue.main.async {
                        self?.viewInput?.isAuth = result
                    }
                }
            }
        }
        
        func isAuth() -> Bool {
            AuthManager.share.isAuth()
        }
}

  
