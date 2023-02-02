//
//  Date+toString.swift
//  ShikiApp
//
//  Created by Сергей Черных on 01.02.2023.
//

import Foundation

extension Date {
    
    func convertToString(with format: String, relative: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        var dateString = dateFormatter.string(from: self)
        
        guard relative else { return dateString }
        
        if Calendar.current.isDateInToday(self) {
            var array = dateString.components(separatedBy: ",")
            array[0] = "Сегодня"
            dateString = array.joined(separator: ",")
        } else if Calendar.current.isDateInYesterday(self) {
            var array = dateString.components(separatedBy: ",")
            array[0] = "Вчера"
            dateString = array.joined(separator: ",")
        }
        return dateString
    }
}
