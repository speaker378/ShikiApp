//
//  UserRatesProvider.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 08.04.2023.
//

final class UserRatesManager: UserRatesManagerProtocol {

    // MARK: - Private properties
    
    private let userFactory: UsersRequestFactoryProtocol
    private let userRatesFactory: UserRatesRequestFactoryProtocol
    private var userID: Int?

    // MARK: - Constructions

    init() {
        userRatesFactory = ApiFactory.makeUserRatesApi()
        userFactory = ApiFactory.makeUsersApi()
    }

    // MARK: - Functions
    
    func createUserRate(userRate: UserRatesModel, errorHandler: @escaping (String) -> Void) {
        let state = makeState(userRate: userRate)
        getUserID { [weak self] userID in
            guard let self, let userID else { return }
            self.userRatesFactory.postEntity(
                userId: userID,
                targetId: userRate.targetID,
                targetType: UserRatesTargetType(rawValue: userRate.target) ?? .anime,
                state: state
            ) { response, error in
                if let response {
                    userRate.userRateID = response.id
                }
                if let error {
                    errorHandler(error)
                }
            }
        }
    }
    
    func updateUserRate(userRate: UserRatesModel, errorHandler: @escaping (String) -> Void) {
        let state = makeState(userRate: userRate)
        userRatesFactory.putEntity(id: userRate.userRateID, state: state) { _, error in
            if let error {
                errorHandler(error)
            }
        }
    }
    
    func removeUserRate(userRateID id: Int, errorHandler: @escaping (String) -> Void) {
        userRatesFactory.deleteEntity(id: id) { _, error in
            if let error {
                errorHandler(error)
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
        } else {
            completion(nil)
        }
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
