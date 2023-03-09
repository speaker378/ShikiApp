//
//  RanobeEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 01.02.2023.
//

import Foundation

typealias RanobeContentStatus = MangaContentStatus

enum RanobeContentKind: String, CaseIterable, Codable {
    case lightNovel = "light_novel"
    case novel
}
