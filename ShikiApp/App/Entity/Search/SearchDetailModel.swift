//
//  SearchDetailModel.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 17.02.2023.
//

import Foundation

struct SearchDetailModel: Equatable {
    
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
    let episodesText: String
    let volumes: Int?
    let chapters: Int?
    let duration: Int?
    let durationOrVolumes: String
    let rateList: [String]
    let userRate: UserRateModel?
}

struct UserRateModel: Equatable {
    let id: Int
    let targetID: Int
    let targetType: String?
    let episodes: Int
    let rewatched: Int
    let chapters: Int
    let volumes: Int
    let score: Int
    let status: String
}

final class SearchDetailModelFactory {
    
    func makeDetailModel(from source: SearchDetailContentProtocol) -> SearchDetailModel {
        let delimiter = "·"
        let kind = extractKind(source.kind)
        let status = extractStatus(status: source.status, kind: kind)
        let userRate = extractUserRate(source.userRate, targetID: source.id)
        
        let airedReleasedDates = extractYears(
            airedOn: source.airedOn,
            releasedOn: source.releasedOn,
            kind: source.kind
        )
        let episodesText = makeEpisodesText(
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            kind: kind,
            status: status
        )
        let duration = extractDuration(
            duration: source.duration,
            volumes: source.volumes,
            chapters: source.chapters
        )
        return SearchDetailModel(
            id: source.id,
            imageUrlString: extractUrlString(image: source.image),
            title: extractTitle(name: source.name, russian: source.russian),
            kind: kind,
            kindAndDate: "\(kind) \(delimiter) \(airedReleasedDates)",
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
    
    func extractUserRate(_ userRate: UserRatesDTO?, targetID: Int) -> UserRateModel? {
        guard let userRate else { return nil }
        return UserRateModel(
            id: userRate.id,
            targetID: targetID,
            targetType: userRate.targetType,
            episodes: userRate.episodes,
            rewatched: userRate.rewatches,
            chapters: userRate.chapters,
            volumes: userRate.volumes,
            score: userRate.score,
            status: userRate.status
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
    func makeRatesList(status: String, userRates: UserRateModel?) -> [String] {
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
