//
//  UserModel.swift
//  ShikiApp

import UIKit

struct UserViewModel {
    
    let nickname: String
    let avatarURLString: String?
    let sex: String?
    let fullYears: Int?
    let website: String?
}

final class UserModelFactory {

    // MARK: - Functions
    
    func makeModel(from user: UserDTO) -> UserViewModel {
        let profileImageUrl = extractImageAddress(from: user.image?.x160)
        let userName = user.nickname
        let userSex = user.sex
        let userAge = user.fullYears
        let userWebSite = user.webSite
        
        return UserViewModel(
            nickname: userName,
            avatarURLString: profileImageUrl,
            sex: userSex,
            fullYears: userAge,
            website: userWebSite
        )
    }
    
    private func extractImageAddress(from avatar: String?) -> String {
        let result = String()
        guard let avatar else { return result }
        let imageUrl = avatar
        return imageUrl
    }
}
