//
//  SearchModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import UIKit

// MARK: - SearchModelFactory

final class SearchModelFactory {

    // MARK: - Functions

    func makeModels(from source: [SearchContentProtocol]) -> [SearchModel] {
        return source.compactMap(self.viewModel)
    }

    // MARK: - Private functions
    
    private func viewModel(from source: SearchContentProtocol) -> SearchModel {
        let service = ConvertationService()
        let delimiter = "·"
        let id = source.id
        let urlString = service.extractUrlString(image: source.image)
        let airedReleasedDates = service.extractYears(
            airedOn: source.airedOn,
            releasedOn: source.releasedOn,
            kind: source.kind
        )
        let title = source.russian ?? source.name
        let kind = service.extractKind(source.kind)
        let score = Score(
            value: service.extractScore(source.score),
            color: service.extractScoreColor(source.score)
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
