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
        let delimiter = "·"
        let id = source.id
        let urlString = extractUrlString(image: source.image)
        let airedReleasedDates = extractYears(
            airedOn: source.airedOn,
            releasedOn: source.releasedOn,
            kind: source.kind
        )
        let title = source.russian ?? source.name
        let kind = extractKind(kind: source.kind)
        let score = Score(
            value: extractScore(score: source.score),
            color: extractScoreColor(score: source.score)
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
    private var dateYearFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormatter.yearMonthDay
        formatter.timeZone = TimeZone(identifier: "GMT")
        return formatter
    }()

    private func extractYear(date: String?) -> String {

        guard let date,
              let date = dateYearFormatter.date(from: date) else { return "..." }
        return "\(Calendar.current.component(.year, from: date))"
    }
    
    private func extractYears(airedOn: String?, releasedOn: String?, kind: String?) -> String {
        
        let airedYear = extractYear(date: airedOn)
        let releasedYear = extractYear(date: releasedOn)
        return isSingleDateKind(kind: kind) || releasedYear == airedYear ? airedYear : "\(airedYear)–\(releasedYear)"
    }
    
    private func extractUrlString(image: ImageDTO?) -> String {
        
        guard let image else { return "" }
        return "\(Constants.Url.baseUrl)\(image.preview)"
    }

    private func extractKind(kind: String?) -> String {
        
        guard let kind,
              let kindDescription = Constants.kindsDictionary[kind]
        else { return "" }
        return kindDescription
    }
    
    private func isSingleDateKind(kind: String?) -> Bool {
        
        guard let kind else { return true}
        return Constants.singleDateKinds.contains(kind)
    }
    
    private func extractScore(score: String?) -> String {
        
        guard let score,
              let floatScore = Float(score) else { return "" }
        return String(format: "%.1f", floatScore)
    }
    
    private func extractScoreColor(score: String?) -> UIColor {
        
        Constants.scoreColors[score?.first ?? " "] ?? AppColor.line
    }
    
    private func extractStatus(status: String?, kind: String?) -> String {
        guard let status, let kind else { return "" }
        switch kind {
        case "manga", "manhwa", "manhua", "light_novel", "novel", "one_shot", "doujin":
            return Constants.mangaStatuses[status] ?? ""
        default:
            return Constants.animeStatuses[status] ?? ""
        }
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
