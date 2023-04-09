//
//  SearchModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import UIKit

// MARK: - SearchModelFactory

final class SearchModelFactory: PrepareInfoProtocol {

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
        let kind = extractKind(source.kind)
        let score = Score(
            value: extractScore(source.score),
            color: extractScoreColor(source.score)
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

/// подготовка отображения информации на экранах Поиска и детальной инфы о тайтле
protocol PrepareInfoProtocol {
    
    func extractTitle(name: String, russian: String?) -> String
    func extractYear(_ date: String?) -> String
    func extractYears(airedOn: String?, releasedOn: String?, kind: String?) -> String
    func extractUrlString(image: ImageDTO?) -> String
    func extractKind(_ kind: String?) -> String
    func isSingleDateKind(_ kind: String?) -> Bool
    func extractScore(_ score: String?) -> String
    func extractScoreColor(_ score: String?) -> UIColor
    func extractStatus(status: String?, kind: String?) -> String
}

extension PrepareInfoProtocol {

    // MARK: - Private properties
    
    private var dateYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormatter.yearMonthDay
        formatter.timeZone = TimeZone(identifier: "GMT")
        return formatter
    }

    // MARK: - Functions
    
    func extractTitle(name: String, russian: String?) -> String {
        if let russian, !russian.isEmpty {
            return russian
        } else if name.isEmpty {
            return Texts.Empty.noTitle
        }
        return name
    }
    
    func extractYear(_ date: String?) -> String {
        guard let date, let date = dateYearFormatter.date(from: date) else { return "..." }
        return "\(Calendar.current.component(.year, from: date))"
    }
    
    func extractYears(airedOn: String?, releasedOn: String?, kind: String?) -> String {
        let airedYear = extractYear(airedOn)
        let releasedYear = extractYear(releasedOn)
        return isSingleDateKind(kind) || releasedYear == airedYear ? airedYear : "\(airedYear)–\(releasedYear)"
    }
    
    func extractUrlString(image: ImageDTO?) -> String {
        guard let image else { return "" }
        return "\(Constants.Url.baseUrl)\(image.preview)"
    }
    
    func extractKind(_ kind: String?) -> String {
        guard let kind, let kindDescription = Constants.kindsDictionary[kind] else { return "" }
        return kindDescription
    }
    
    func isSingleDateKind(_ kind: String?) -> Bool {
        guard let kind else { return true }
        return Constants.singleDateKinds.contains(kind)
    }
    
    func extractScore(_ score: String?) -> String {
        guard let score, let floatScore = Float(score) else { return "" }
        return String(format: "%.1f", floatScore)
    }
    
    func extractScoreColor(_ score: String?) -> UIColor {
        Constants.scoreColors[String(score?.first ?? " ")] ?? AppColor.line
    }
    
    func extractStatus(status: String?, kind: String?) -> String {
        guard let status, let kind else { return "" }
        let isManga = MangaContentKind.allCases.map { $0.rawValue }.contains(kind)
        return isManga ? Constants.mangaStatuses[status] ?? "" : Constants.animeStatuses[status] ?? ""
    }
}
