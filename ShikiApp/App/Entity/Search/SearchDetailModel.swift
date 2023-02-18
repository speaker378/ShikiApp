//
//  SearchDetailModel.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 17.02.2023.
//

import Foundation

struct SearchDetailModel {
    
    let id: Int
    let imageUrlString: String
    let title: String
    let kind: String
    let kindAndDate: String
    let score: String
    let status: String
    let description: String
    let rating: String?
    let studios: [String]
    let genres: [String]
    let episodes: Int?
    let episodesAired: Int?
    let volumes: Int?
    let duration: Int?
}

final class SearchDetailModelFactory {
    
    func makeDetailModel(from source: SearchDetailContentProtocol) -> SearchDetailModel {
        let delimiter = "·"
        let urlString = extractUrlString(source.image)
        let airedReleasedDates = extractYears(
            airedOn: source.airedOn,
            releasedOn: source.releasedOn,
            kind: source.kind
        )
        let kind = extractKind(source.kind)
        let kindAndDate = "\(kind) \(delimiter) \(airedReleasedDates)"
        let status = extractStatus(status: source.status, kind: source.kind)
        let rating = extractRating(source.rating)
        let score = extractScore(score: source.score)
        
        return SearchDetailModel(
            id: source.id,
            imageUrlString: urlString,
            title: source.russian ?? source.name,
            kind: kind,
            kindAndDate: kindAndDate,
            score: score,
            status: status,
            description: source.description?.removeTags() ?? "",
            rating: rating,
            studios: source.studioList,
            genres: source.genreList,
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            volumes: source.volumes,
            duration: source.duration
        )
    }
    
    private var dateYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormatter.yearMonthDay
        formatter.timeZone = TimeZone(identifier: "GMT")
        return formatter
    }()

    private func extractYear(_ date: String?) -> String {
        guard let date, let date = dateYearFormatter.date(from: date) else { return "..." }
        return "\(Calendar.current.component(.year, from: date))"
    }
    
    private func extractYears(airedOn: String?, releasedOn: String?, kind: String?) -> String {
        let airedYear = extractYear(airedOn)
        let releasedYear = extractYear(releasedOn)
        return isSingleDateKind(kind) || releasedYear == airedYear ? airedYear : "\(airedYear)–\(releasedYear)"
    }
    
    private func extractUrlString(_ image: ImageDTO?) -> String {
        guard let image else { return "" }
        return "\(Constants.Url.baseUrl)\(image.preview)"
    }

    private func extractKind(_ kind: String?) -> String {
        guard let kind, let kindDescription = Constants.kindsDictionary[kind]
        else { return "" }
        return kindDescription
    }
    
    private func isSingleDateKind(_ kind: String?) -> Bool {
        guard let kind else { return true}
        return Constants.singleDateKinds.contains(kind)
    }
    
    private func extractScore(score: String?) -> String {
        guard let score, let floatScore = Float(score) else { return "0.0" }
        return String(format: "%.1f", floatScore)
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
    
    private func extractRating(_ rating: String?) -> String {
        guard let rating else { return "" }
        return Constants.rating[rating] ?? ""
    }
}
