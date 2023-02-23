//
//  SeasonViewModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 22.02.2023.
//

import Foundation

// MARK: - SeasonViewModel

struct SeasonViewModel {
    let season: String
    let year: Int
    var description: String {
        "\(season) \(year)"
    }
}

// MARK: - SeasonViewModelFactory

final class SeasonViewModelFactory {

    // MARK: - Functions

    func build() -> [SeasonViewModel] {
        var result: [SeasonViewModel] = []
        guard let year = Calendar.current.dateComponents([.year], from: Date()).year else { return result }
        let seasons = Seasons
            .allCases
            .enumerated()
            .sorted(by: { $0.offset < $1.offset })
            .map { $0.element.rawValue }

        for yearOffset in 0 ... 1 {
            for season in seasons {
                result.append(SeasonViewModel(season: season, year: year - yearOffset))
            }
        }
        return result
    }
}
