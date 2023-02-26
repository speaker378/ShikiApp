//
//  UserRatesContentProtocol.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 23.02.2023.
//

import Foundation

// MARK: - SearchContent

protocol UserRatesContentProtocol {
    
    var id: Int { get }
    var name: String { get }
    var target: String { get }
    var russian: String? { get }
    var image: ImageDTO? { get }
    var kind: String? { get }
    var score: String? { get }
    var ongoingStatus: String? { get }
    var status: String? { get }
    var totalEpisodes: Int? { get }
    var watchingEpisodes: Int? { get }
}
