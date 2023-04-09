//
//  UserRatesProvider.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 08.04.2023.
//

import Foundation

final class UserRatesManager: UserRatesManagerProtocol {

    // MARK: - Properties

    // MARK: - Private properties
    
    private let userFactory: UsersRequestFactoryProtocol
    private let userRatesFactory: UserRatesRequestFactoryProtocol
    private var userID: Int?

    // MARK: - Constructions

    init() {
        userRatesFactory = ApiFactory.makeUserRatesApi()
        userFactory = ApiFactory.makeUsersApi()
    }
    
    // TODO: - убрать значение типа по дефолту
    func createUserRate(userRate: UserRatesModel) {
        let state = makeState(userRate: userRate)
        
        getUserID { [weak self] userID in
            guard let self, let userID else { return }
            print("@@ create userRate: I create a new entry!" )
            print("@@ userID = \(userID)" )
            print("@@ targetID = \(userRate.targetID)" )
            print("@@ targetType = \(UserRatesTargetType(rawValue: userRate.target) ?? .anime)" )
            print("@@ state = \(state)" )
            
//            userRate.userRateID = 1234
            
            self.userRatesFactory.postEntity(
                userId: userID,
                targetId: userRate.targetID,
                targetType: UserRatesTargetType(rawValue: userRate.target) ?? .anime,
                state: state
            ) { response, error in
                if let response {
                    userRate.userRateID = response.id
                    print("@@ create userRate: \(response)")
                }
                if let error {
                    print("@@ create userRate: Can't create list. Error: \(error)")
                }
            }
        }
    }
    
    func updateUserRate(userRate: UserRatesModel) {
        let state = makeState(userRate: userRate)
        print("@@ update userRate: I update userRate iwth id \(userRate.userRateID)!" )
        print("@@ targetID = \(userRate.targetID)" )
        print("@@ targetType = \(String(describing: UserRatesTargetType(rawValue: userRate.target)))" )
        print("@@ state = \(state)" )
        userRatesFactory.putEntity(id: userRate.userRateID, state: state) { response, error in
            if let response {
                print("@@ update userRate: \(response)")
            }
            if let error {
                print("@@ update userRate: Can't update list. Error: \(error)")
            }
        }
    }
    
    func removeUserRate(userRateID id: Int) {
        print("@@ I delete userRate with id \(id)")
        userRatesFactory.deleteEntity(id: id) { response, error in
            if let response {
                print("@@ delete userRate: \(response)")
            }
            if let error {
                print("@@ delete userRate: Can't remove list. Error: \(error)")
            }
        }
    }

    // MARK: - Private functions
    
    private func getUserID(completion: @escaping (Int?) -> Void) {
        guard userID == nil else {
            completion(userID)
            return
        }
        if AuthManager.share.isAuth() {
            userFactory.whoAmI { user, _ in
                if let user {
                    completion(user.id)
                }
            }
        }
        completion(nil)
    }
    
    private func makeState(userRate: UserRatesModel) -> UserRatesState {
        return UserRatesState(
            status: UserRatesStatus(rawValue: userRate.status),
            score: Int(userRate.score.value),
            chapters: userRate.chapters,
            episodes: userRate.episodes,
            volumes: userRate.volumes,
            rewatches: userRate.rewatches,
            text: nil
        )
    }
}
