//
//  SeasonModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.02.2023.
//

import Foundation

// MARK: - SeasonModel

struct SeasonModel {

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

    // MARK: - Private properties

    private let removeSeasonsByMonth = [
        [0, 5],
        [0, 5],
        [1, 4],
        [1, 4],
        [1, 4],
        [2, 3],
        [2, 3],
        [2, 3],
        [3, 2],
        [3, 2],
        [3, 2],
        [4, 1]
    ]

    // MARK: - Functions

    func build() -> [SeasonModel] {
        var result: [SeasonModel] = []
        guard
            let currentYear = Calendar.current.dateComponents([.year], from: Date()).year,
            let currentMonth = Calendar.current.dateComponents([.month], from: Date()).month
        else { return result }
        let seasons = Seasons.descriptions
        for year in currentYear - 1 ... currentYear + 1 {
            for season in seasons {
                result.append(SeasonModel(season: season, year: year))
            }
        }
        result.removeFirst(removeSeasonsByMonth[currentMonth - 1][0])
        result.removeLast(removeSeasonsByMonth[currentMonth - 1][1])
        return result.reversed()
    }
}
