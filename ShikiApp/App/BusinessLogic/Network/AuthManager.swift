//
//  AuthManager.swift
//  ShikiApp
//
//  Created by Сергей Черных on 12.02.2023.
//

import Foundation

protocol AuthManagerProtocol {
    
    func isAuth() -> Bool
    func getToken() -> String?
    func auth(handler: @escaping (Bool) -> Void)
}

final class AuthManager: AuthManagerProtocol {

    // MARK: - Properties
    
    static let share = AuthManager()

    // MARK: - Private properties
    
    private let oAuth2Manager = OAuth2Manager()
    private let keychain = KeychainManager()
    private let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String
    private let account = "user"
    private let request: OAuth2Request? = {
        guard let clientId = ProcessInfo.processInfo.environment["clientId"],
              let clientSecret = ProcessInfo.processInfo.environment["clientSecret"]
        else { return nil }
        return OAuth2Request(
            authUrl: "\(Constants.Url.baseUrl)/oauth/authorize",
            tokenUrl: "\(Constants.Url.baseUrl)/oauth/token",
            clientId: clientId,
            redirectUri: Constants.Url.redirectUri,
            clientSecret: clientSecret,
            scopes: ["user_rates", "comments", "topics"]
        )
    }()
    private var credential: OAuth2Credential?

    // MARK: - Construction
    
    private init() {
        guard let bundleName else { return }
        self.credential = keychain.get(service: bundleName, account: account, type: OAuth2Credential.self)
        if tokenIsNeedUpdate() { updateToken() }
    }

    // MARK: - Functions
    
    func isAuth() -> Bool {
        if credential?.accessToken == nil { return false }
        return true
    }
    
    func getToken() -> String? {
        if tokenIsNeedUpdate() { updateToken() }
        return credential?.accessToken
    }
    
    func auth(handler: @escaping (Bool) -> Void) {
        guard let request else {
            handler(false)
            return
        }
        
        oAuth2Manager.auth(with: request) { [self] result in
            guard let result = result,
            let bundleName
            else {
                handler(false)
                return
            }
            self.credential = result
            self.keychain.save(result, service: bundleName, account: account)
            handler(true)
        }
    }
    
    func logOut() {
        self.credential = nil
        guard let bundleName else { return }
        keychain.delete(service: bundleName, account: account)
    }

    // MARK: - Private functions
    
    private func updateToken() {
        guard let refreshToken = credential?.refreshToken,
            let request = request?.makeRefreshTokenURL(refreshToken: refreshToken)
        else { return }
        oAuth2Manager.requestToken(for: request) { [self] result in
            guard let result = result,
                  let bundleName = self.bundleName
            else { return }
            self.credential = result
            self.keychain.delete(service: bundleName, account: self.account)
            self.keychain.save(result, service: bundleName, account: self.account)
        }
    }
    
    private func tokenIsNeedUpdate() -> Bool {
        guard let expire = credential?.expire else { return false }
        let limit = Date.now.addingTimeInterval(300)
        if expire < limit {
            return true
        } else {
            return false
        }
    }
}
