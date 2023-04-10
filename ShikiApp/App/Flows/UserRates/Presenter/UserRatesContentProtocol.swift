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
    var russian: String? { get }
    var image: ImageDTO? { get }
    var url: String? { get }
    var kind: String? { get }
    var score: String? { get }
    var status: String? { get }
    var episodes: Int? { get }
    var episodesAired: Int? { get }
    var volumes: Int? { get }
    var chapters: Int? { get }
    var airedOn: String? { get }
    var releasedOn: String? { get }
}
