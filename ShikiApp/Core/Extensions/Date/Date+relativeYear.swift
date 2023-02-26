//
//  Date+RelativeYear.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 25.02.2023.
//

import Foundation

extension Date {
    
    func getRelativeYear(_ offset: Int = 0 ) -> Int {
        return offset + (Calendar.current.dateComponents([.year], from: self).year ?? 0)
    }
}
