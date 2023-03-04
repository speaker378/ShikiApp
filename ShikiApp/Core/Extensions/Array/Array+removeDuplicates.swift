//
//  Array+removeDuplicates.swift
//  ShikiApp
//
//  Created by Сергей Черных on 02.03.2023.
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self where !result.contains(value) {
            result.append(value)
        }
        self = result
    }
}
