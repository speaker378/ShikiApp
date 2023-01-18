//
//  Forums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

typealias ForumsResponse = [Forum]

struct Forum: Codable {
    let id: Int
    let position: Int
    let name: String?
    let permalink: String?
    let url: String
}
