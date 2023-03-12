//
//  SearchDetailModel.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 17.02.2023.
//

import UIKit

struct SearchDetailModel {

    // MARK: - Properties
    
    let id: Int
    let type: String
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
    let episodesText: String
    let volumes: Int?
    let chapters: Int?
    let duration: Int?
    let durationOrVolumes: String
    let rateList: [String]
    var userRate: UserRatesModel?

    // MARK: - Functions
    
    mutating func configureUserRate(
        content: SearchDetailModel,
        status: String,
        score: Score? = nil,
        episodes: Int? = nil,
        rewatches: Int? = nil,
        chapters: Int? = nil,
        volumes: Int? = nil
    ) {
        self.userRate = UserRatesModel(
            id: content.id,
            target: content.type,
            imageUrlString: content.imageUrlString,
            title: content.title,
            kind: content.kind,
            ongoingStatus: content.status,
            watchingEpisodes: content.episodesText,
            totalEpisodes: "\(content.episodes ?? 0)",
            score: score ?? Score(value: "0.0", color: AppColor.textMinor),
            status: status,
            statusImage: Constants.watchingImageStatuses[status] ?? UIImage(),
            episodes: episodes ?? content.userRate?.episodes,
            rewatches: rewatches ?? content.userRate?.rewatches,
            chapters: chapters ?? content.userRate?.chapters,
            volumes: volumes ?? content.userRate?.volumes
        )
    }
}

extension SearchDetailModel: Equatable {
    static func == (lhs: SearchDetailModel, rhs: SearchDetailModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func > (lhs: SearchDetailModel, rhs: SearchDetailModel) -> Bool {
        return lhs.id > rhs.id
    }
}

final class SearchDetailModelFactory {
    
    func makeDetailModel(from source: SearchDetailContentProtocol) -> SearchDetailModel {
        let delimiter = "·"
        let kind = extractKind(source.kind)
        let status = extractStatus(status: source.status, kind: kind)
        let years = extractYears(airedOn: source.airedOn, releasedOn: source.releasedOn, kind: source.kind)
        let duration = extractDuration(duration: source.duration, volumes: source.volumes, chapters: source.chapters)
        let userRate = extractUserRate(
            source.userRate,
            type: extractType(kind: source.kind),
            imageString: extractUrlString(image: source.image),
            title: extractTitle(name: source.name, russian: source.russian),
            kind: kind,
            status: status,
            episodes: source.episodes ?? 0
        )
        let episodesText = makeEpisodesText(
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            kind: kind,
            status: status
        )
        
        return SearchDetailModel(
            id: source.id,
            type: extractType(kind: source.kind),
            imageUrlString: extractUrlString(image: source.image),
            title: extractTitle(name: source.name, russian: source.russian),
            kind: kind,
            kindAndDate: "\(kind) \(delimiter) \(years)",
            score: extractScore(source.score),
            status: status,
            description: source.description?.removeTags() ?? Texts.Empty.noDescription,
            rating: extractRating(source.rating),
            studios: extractStudios(studios: source.studios, publishers: source.publishers),
            genres: extractGenres(source.genres),
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            episodesText: episodesText,
            volumes: source.volumes,
            chapters: source.chapters,
            duration: source.duration,
            durationOrVolumes: duration,
            rateList: makeRatesList(status: status, userRates: userRate),
            userRate: userRate
        )
    }
}

extension SearchDetailModelFactory: PrepareInfoProtocol {

    // MARK: - Functions
    
    func extractType(kind: String?) -> String {
        guard let kind else { return "" }
        return AnimeContentKind(rawValue: kind) != nil ? "Anime" : "Manga"
    }
    
    func extractScore(_ score: String?) -> String {
        guard let score, let floatScore = Float(score) else { return "" }
        let scoreString = String(format: "%.1f", floatScore)
        if scoreString == "0.0" {
            return Texts.Empty.noScore
        }
        return scoreString
    }
    
    func extractRating(_ rating: String?) -> String? {
        guard let rating else { return nil }
        return Constants.rating[rating]
    }
    
    func extractGenres(_ genres: [GenreDTO]?) -> [String] {
        guard let genres, !genres.isEmpty else { return [] }
        return genres.compactMap { $0.russian }
    }
    
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
    
    /// подготовка значений для списка просмотра
    func extractUserRate(
        _ userRate: UserRatesDTO?,
        type: String,
        imageString: String,
        title: String,
        kind: String,
        status: String,
        episodes: Int
    ) -> UserRatesModel? {
        guard let userRate else { return nil }
        let delimiter = "·"
        let score = Score(
            value: extractScore(String(userRate.score)),
            color: extractScoreColor(String(userRate.score))
        )
        return UserRatesModel(
            id: userRate.id,
            target: type,
            imageUrlString: imageString,
            title: title,
            kind: kind,
            ongoingStatus: status,
            watchingEpisodes: "\(userRate.episodes ?? 0)/\(episodes) \(delimiter) ",
            totalEpisodes: "\(episodes)",
            score: score,
            status: userRate.status,
            statusImage: Constants.watchingImageStatuses[status] ?? UIImage(),
            episodes: userRate.episodes,
            rewatches: userRate.rewatches,
            chapters: userRate.chapters,
            volumes: userRate.volumes
        )
    }
    
    func makeEpisodesText(episodes: Int?, episodesAired: Int?, kind: String, status: String) -> String {
        guard let episodesCount = episodes, kind != Constants.kindsDictionary["movie"] else { return "" }
        let episodes = episodesCount == 0 ? " ?" : String(episodesCount)
        var string = ""
        if status == Constants.mangaStatuses["ongoing"] || status == Constants.animeStatuses["ongoing"],
           let aired = episodesAired {
            string = "\(aired)/\(episodes) \(Texts.OtherMessage.episodes)"
        } else {
            string = "\(episodes) \(Texts.OtherMessage.episodes)"
        }
        return string
    }
    
    /// подготовка значений для выпадающего списка к кнопке "Добавить в список"
    func makeRatesList(status: String, userRates: UserRatesModel?) -> [String] {
        if status == Constants.mangaStatusDictionary["anons"] || status == Constants.animeStatusDictionary["anons"] {
            return [Texts.ListTypesSelectItems.planned, Texts.ButtonTitles.removeFromList]
        }
        var array = RatesTypeItemEnum.allCases.map { $0.getString() }
        array.removeFirst()
        if userRates != nil {
            array.append(Texts.ButtonTitles.removeFromList)
        }
        return array
    }
}
