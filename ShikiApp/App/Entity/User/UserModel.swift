//
//  UserModel.swift
//  ShikiApp

import UIKit

struct UserViewModel {
    
    let nickname: String
    let avatarURLString: String?
    let sex, fullYears: String?
    let website: String?
}

enum UserImageSize {
    case x160, x148, x80, x64, x48, x32, x16
}

final class UserModelFactory {
    
    // MARK: - Functions
    
    func convertModel(from user: UserProfileDTO) -> UserViewModel {
        let profileImageUrl = extractImageAddress(from: user.avatar)
        let userName = user.nickname
        let userSex = user.sex
        let userAge = user.fullYears
        let userWebSite = user.website
        
        return UserViewModel(
            nickname: userName,
            avatarURLString: profileImageUrl,
            sex: userSex,
            fullYears: userAge,
            website: userWebSite)
    }
    
    private func extractImageAddress(from avatar: String?) -> String {
        var result = String()
        guard let avatar else { return result }
        let imageUrl = avatar
        return imageUrl
    }
}
