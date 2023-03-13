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
    func didPressedLinkButton()
    func isAuth() -> Bool
}

final class ProfilePresenter: ProfileViewOutputProtocol {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & ProfileViewInputProtocol)?

    // MARK: - Private properties
    
    private let apiFactory = ApiFactory.makeUsersApi()
    private let modelFactory = UserModelFactory()
    private var userData: UserDTO?

    // MARK: - Functions
    
    func fetchData() {
        if isAuth() {
            apiFactory.whoAmI { [weak self] data, _ in
                guard let data else { return }
                self?.userData = data
                self?.viewInput?.model = self?.modelFactory.makeModel(from: data)
                self?.viewInput?.isAuth = true
            }
        }
    }
    
    func didPressedLogoutButton() {
        if isAuth() {
            AuthManager.share.logOut()
            userData = nil
            viewInput?.model = nil
            viewInput?.isAuth = false
        } else {
            AuthManager.share.auth { [weak self] _ in
                self?.fetchData()
            }
        }
    }
    
    func isAuth() -> Bool {
        AuthManager.share.isAuth()
    }
    
    func didPressedLinkButton() {
        if let url = URL(string: viewInput?.model?.website ?? "") {
                UIApplication.shared.open(url)
            }
    }
}

  
