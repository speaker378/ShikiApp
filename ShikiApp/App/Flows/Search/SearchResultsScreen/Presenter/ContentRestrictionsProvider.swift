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
}

// MARK: - ContentRestrictionsProvider

final class ContentRestrictionsProvider: ContentRestrictionsProviderProtocol {

    // MARK: - Private properties

    private var notificationCenter = NotificationCenter.default
    private var censored = true
    private var isActual = false
    private let userFactory: UsersRequestFactoryProtocol

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

    // MARK: - Private functions

    @objc private func onChangeCredentials(_ notification: Notification) {
        setCensoredValue()
    }
    
    private func setCensoredValue() {
        isActual = false
        userFactory.whoAmI { [weak self] user, _ in
            if let user {
                self?.censored = user.fullYears ?? 0 < Constants.CensoredParameters.uncensoredAge
            } else {
                self?.censored = true
            }
            self?.isActual.toggle()
        }
    }
}
