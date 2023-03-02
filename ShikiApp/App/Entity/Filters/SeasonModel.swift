//
//  SeasonModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.02.2023.
//

import Foundation

// MARK: - SeasonModel

struct SeasonModel: Equatable {

    // MARK: - Private properties

    private let year: Int
    private let season: String

    // MARK: - Properties

    var description: String { "\(season) \(year)" }

    // MARK: - Constructions

    init(season: String, year: Int) {
        self.year = year
        self.season = season

    }
}

// MARK: - SeasonModelFactory

final class SeasonModelFactory {

    // MARK: - Functions
    
    func build() -> [SeasonModel] {
        var result: [SeasonModel] = []
        guard
            var startDate = Calendar.current.date(byAdding: .month, value: -12, to: .now),
            let stopDate = Calendar.current.date(byAdding: .month, value: 6, to: .now)
        else { return result }
        
        while startDate < stopDate {
            guard
                let month = Calendar.current.dateComponents([.month], from: startDate).month,
                let year = Calendar.current.dateComponents([.year], from: startDate).year
            else { return result }
            result.append(SeasonModel(season: seasonByMonth(month).rawValue, year: year))
            startDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate) ?? stopDate
        }
        result.reverse()
        result.removeDuplicates()
        return result
    }

    // MARK: - Private functions
    
    private func seasonByMonth(_ month: Int) -> Seasons {
        switch month {
        case 3...5:
            return Seasons.spring
        case 6...8:
            return Seasons.summer
        case 9...11:
            return Seasons.fall
        default:
            return Seasons.winter
        }
    }
}
