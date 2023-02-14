//
//  SearchContentProtocol.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import Foundation

// MARK: - SearchContent

protocol SearchContentProtocol {
    
    var id: Int { get }
    var name: String { get }
    var russian: String? { get }
    var image: ImageDTO? { get }
    var kind: String? { get }
    var score: String? { get }
    var airedOn: String? { get }
    var releasedOn: String? { get }
}
