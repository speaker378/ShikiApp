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
        let userSex = convertUserSexFromEnglish(from: user.sex, fullYears: user.fullYears)
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
    
    private func convertUserSexFromEnglish(from sex: String?, fullYears: Int?) -> String {
        var result = ""
        if sex == "" || sex == nil { return result }
        if fullYears != nil {
            result = sex != "male" ? Texts.SexInRussian.femaleCommaAndSpace : Texts.SexInRussian.maleCommaAndSpace
        } else {
            result = sex != "male" ? Texts.SexInRussian.female : Texts.SexInRussian.male
        }
        return result
    }
}
