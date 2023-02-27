//
//  String+toDate.swift
//  ShikiApp
//
//  Created by Сергей Черных on 01.02.2023.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
        let date = dateFormatter.date(from: self)
        return date
    }
}
