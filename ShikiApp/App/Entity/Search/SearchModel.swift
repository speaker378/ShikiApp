//
//  SearchModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import Foundation
import UIKit

// MARK: - SearchModelFactory

final class SearchModelFactory {

    // MARK: - Functions

    func makeModels(from source: [SearchContent]) -> [SearchModel] {
        return source.compactMap(self.viewModel)
    }

    // MARK: - Private fnctions
    
    private func viewModel(from source: SearchContent) -> SearchModel {
        let delimiter = "·"
        let id = source.id
        let urlString = SearchFormatters.extractUrlString(image: source.image)
        let airedReleasedDates = SearchFormatters.extractYears(
            airedOn: source.airedOn,
            releasedOn: source.releasedOn,
            kind: source.kind
        )
        let title = source.russian ?? source.name
        let kind = SearchFormatters.extractKind(kind: source.kind)
        let score = Score(
            value: SearchFormatters.extractScore(score: source.score),
            color: SearchFormatters.extractScoreColor(score: source.score)
        )
        let subtitle = "\(kind) \(delimiter) \(airedReleasedDates)"

        return SearchModel(
            id: id,
            imageUrlString: urlString,
            title: title,
            subtitle: subtitle,
            score: score
        )
    }
}

// MARK: - SearchModel

struct SearchModel {
    
    let id: Int
    let imageUrlString: String
    let title: String
    let subtitle: String
    let score: Score
}

struct Score {
    let value: String
    let color: UIColor
}
