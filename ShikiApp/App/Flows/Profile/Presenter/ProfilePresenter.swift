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

    private let modelFactory = UserModelFactory()
    private var userData: UserDTO?

    // MARK: - Construction

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onChangeCredentials(_:)),
            name: .credentialsChanged,
            object: nil
        )
    }

    // MARK: - Destructions

    deinit {
        NotificationCenter.default.removeObserver(self, name: .credentialsChanged, object: nil)
    }

    // MARK: - Private functions

    @objc private func onChangeCredentials(_: Notification) {
        self.fetchData()
    }

    // MARK: - Functions
    
    func fetchData() {
        DispatchQueue.main.async {
            if let data = AuthManager.share.getUserInfo() {
                self.userData = data
                self.viewInput?.model = self.modelFactory.makeModel(from: data)
            } else {
                self.userData = nil
                self.viewInput?.model = nil
            }
            self.viewInput?.isAuth = self.isAuth()
        }
    }
    
    func didPressedLogoutButton() {
        if isAuth() {
            AuthManager.share.logOut()
            userData = nil
            viewInput?.model = nil
            viewInput?.isAuth = false
        } else {
            AuthManager.share.auth { [weak self] isLoggedIn in
                if isLoggedIn { self?.fetchData() }
            }
        }
    }
    
    func isAuth() -> Bool {
        AuthManager.share.isAuth()
    }
    
    func didPressedLinkButton() {
        guard let url = URL(string: viewInput?.model?.website ?? "") else {
               return
        }
        if url.absoluteString.contains("http") || url.absoluteString.contains("https") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            guard let httpUrl = URL(string: "https://"+(viewInput?.model?.website ?? "")) else { return }
            UIApplication.shared.open(httpUrl, options: [:], completionHandler: nil)
        }
    }
}

  
