//
//  SeasonModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.02.2023.
//

import Foundation

// MARK: - SeasonModel

struct SeasonModel {

    // MARK: - Properties

    var description: String

    // MARK: - Constructions

    init(season: String, year: Int) {
        description = "\(season) \(year)"
    }
}

// MARK: - SeasonModelFactory

final class SeasonModelFactory {

    // MARK: - Functions

    func build() -> [SeasonModel] {
        var result: [SeasonModel] = []
        guard let year = Calendar.current.dateComponents([.year], from: Date()).year else { return result }
        let seasons = Seasons
            .allCases
            .enumerated()
            .sorted(by: { $0.offset < $1.offset })
            .map { $0.element.rawValue }

        for yearOffset in 0 ... 1 {
            for season in seasons {
                result.append(SeasonModel(season: season, year: year - yearOffset))
            }
        }
        return result
    }
}
