//
//  SearchModelInfoService.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 20.02.2023.
//

import UIKit

// TODO: - Придумать название
/// подготовка отображения информации на экранах Поиска и детальной инфы о тайтле
final class SearchModelInfoService {

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
        guard let kind, let kindDescription = Constants.kindsDictionary[kind]
        else { return "" }
        return kindDescription
    }
    
    func isSingleDateKind(_ kind: String?) -> Bool {
        guard let kind else { return true}
        return Constants.singleDateKinds.contains(kind)
    }
    
    func extractScore(_ score: String?) -> String {
        guard let score, let floatScore = Float(score) else { return "" }
        return String(format: "%.1f", floatScore)
    }
    
    func extractScoreColor(_ score: String?) -> UIColor {
        Constants.scoreColors[score?.first ?? " "] ?? AppColor.line
    }
    
    func extractStatus(status: String?, kind: String?) -> String {
        guard let status, let kind else { return "" }
        let isManga = MangaContentKind.allCases.map { $0.rawValue }.contains(kind)
        return isManga ? Constants.mangaStatuses[status] ?? "" : Constants.animeStatuses[status] ?? ""
    }
    
    func extractRating(_ rating: String?) -> String? {
        guard let rating else { return nil }
        return Constants.rating[rating]
    }
    
    func extractGenres(_ genres: [GenreDTO]?) -> [String] {
        guard let genres, !genres.isEmpty else { return [] }
        return genres.compactMap { $0.russian }
    }
    // TODO: - выводить тут или картинку, или имя
    func extractStudios(studios: [StudioDTO], publishers: [PublisherDTO]) -> [String] {
        if !studios.isEmpty {
            return studios.compactMap { $0.name }
        } else if !publishers.isEmpty {
            return publishers.compactMap { $0.name }
        } else {
            return []
        }
    }
    
    func extractDuration(duration: Int?, volumes: Int?, chapters: Int?) -> String {
        if let duration {
            return "\(duration) \(Texts.OtherMessage.minutes)"
        } else if let volumes, volumes > 1 {
            return "\(volumes) \(Texts.OtherMessage.volumes)"
        } else if let chapters, chapters > 0 {
            return "\(chapters) \(Texts.OtherMessage.chapters)"
        } 
        return ""
    }
    
    func makeEpisodesText(episodes: Int?, episodesAired: Int?, kind: String?, status: String?) -> String {
        guard let episodesCount = episodes, extractKind(kind) != Constants.kindsDictionary["movie"] else { return "" }
        let episodes = episodesCount == 0 ? " ?" : String(episodesCount)
        var string = ""
        let status = extractStatus(status: status, kind: kind)
        if status == Constants.mangaStatusDictionary["ongoing"] || status == Constants.animeStatusDictionary["ongoing"],
           let aired = episodesAired {
            string = "\(aired)/\(episodes) \(Texts.OtherMessage.episodes)"
        } else {
            string = "\(episodes) \(Texts.OtherMessage.episodes)"
        }
        return string
    }
    
    func makeRatesList(kind: String?, status: String?) -> [String] {
        let status = extractStatus(status: status, kind: kind)
        if status == Constants.mangaStatusDictionary["anons"] || status == Constants.animeStatusDictionary["anons"] {
            return [Texts.ListTypesSelectItems.planned, Texts.ButtonTitles.removeFromList]
        }
        var array = RatesTypeItemEnum.allCases.map { $0.getString() }
        array.append(Texts.ButtonTitles.removeFromList)
        return array
    }
}
