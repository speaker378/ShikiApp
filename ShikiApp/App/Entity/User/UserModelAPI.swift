//
//  UserModelAPI.swift
//  ShikiApp

import UIKit

struct UserModelAPI {
    
    let id: Int
    let nickname: String
    let avatarURLString: String?
    let image: UserImageDTO?
    let lastOnlineAt: String?
    let url: String?
    let name, sex, fullYears: String?
    let lastOnline, website: String?
    let location: String?
    let banned: Bool?
    let about, aboutHTML: String?
    let commonInfo: [String]?
    let showComments: Bool?
    let isFriends: Bool?
    let isIgnored: Bool?
    let stats: StatsDTO?
    let styleID: Int?
}

var USERMODEL: UserModelAPI {
    return UserModelAPI(
        id: 27,
        nickname: "Test User",
        avatarURLString: "https://shikimori.one/%D0%92%D0%B5%D0%BB1%D1%87%D0%B0%D0%B9%D1%88%D0%B8%D0%B9",
        image: nil,
        lastOnlineAt: nil,
        url: "shikimori.one",
        name: nil,
        sex: "male",
        fullYears: "44",
        lastOnline: nil,
        website: nil,
        location: nil,
        banned: false,
        about: nil,
        aboutHTML: nil,
        commonInfo: nil,
        showComments: true,
        isFriends: true,
        isIgnored: false,
        stats: nil,
        styleID: 1
        )
}
