//
//  Date+toString.swift
//  ShikiApp
//
//  Created by Сергей Черных on 01.02.2023.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd MMMM, HH:mm"
        var dateString = dateFormatter.string(from: self)
        
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
