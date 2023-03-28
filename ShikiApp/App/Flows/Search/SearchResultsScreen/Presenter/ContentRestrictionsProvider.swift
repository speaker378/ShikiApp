//
//  ContentRestrictionsProvider.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 15.03.2023.
//

import UIKit

// MARK: - ContentRestrictionsProviderProtocol

protocol ContentRestrictionsProviderProtocol {
    func isCensored() -> Bool
    func addObserver(observer: @escaping (Bool) -> Void)
}

// MARK: - ContentRestrictionsProvider

final class ContentRestrictionsProvider: ContentRestrictionsProviderProtocol {

    // MARK: - Private properties

    private var notificationCenter = NotificationCenter.default
    private var censored = true {
        didSet {
            if censored != oldValue {
                for observer in observers {
                    observer(censored)
                }
            }
        }
    }
    private var isActual = false
    private let userFactory: UsersRequestFactoryProtocol
    private var observers: [(Bool) -> Void] = []

    // MARK: - Constructions

    init() {
        userFactory = UsersRequestFactory()
        notificationCenter.addObserver(
            self,
            selector: #selector(onChangeCredentials(_:)),
            name: .credentialsChanged,
            object: nil
        )
        setCensoredValue()
    }

    // MARK: - Destructions

    deinit {
        notificationCenter.removeObserver(self, name: .credentialsChanged, object: nil)
    }

    // MARK: - Functions

    func isCensored() -> Bool {
        let date = Date(timeIntervalSinceNow: Constants.Timeouts.networkRequest)
        repeat {
            if isActual { return censored }
        } while Date() < date
        return true
    }
    
    func addObserver(observer: @escaping (Bool) -> Void) {
        observers.append(observer)
    }

    // MARK: - Private functions

    @objc private func onChangeCredentials(_: Notification) {
        setCensoredValue()
    }

    private func setCensoredValue() {
        if AuthManager.share.isAuth() {
            isActual = false
            userFactory.whoAmI { [weak self] user, _ in
                if let user {
                    self?.censored = user.fullYears ?? 0 < Constants.CensoredParameters.uncensoredAge
                } else {
                    self?.censored = true
                }
                self?.isActual = true
            }
        } else {
            censored = true
        }
    }
}
