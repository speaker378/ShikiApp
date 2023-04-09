//
//  FilterListModel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 14.02.2023.
//

import Foundation

// MARK: - FilterListModel

struct FilterListModel {

    // MARK: - Properties

    var ratingList: String
    var typeList: String
    var statusList: String
    var genreList: String
    var seasonList: String
    var releaseYearStart: String
    var releaseYearEnd: String

    // MARK: - Functions

    func isEmpty() -> Bool {
        return ratingList.isEmpty &&
            typeList.isEmpty &&
            statusList.isEmpty &&
            genreList.isEmpty &&
            seasonList.isEmpty &&
            releaseYearStart.isEmpty &&
            releaseYearEnd.isEmpty
    }
}

// MARK: - FilterListModelFactory

final class FilterListModelFactory {

    // MARK: - Private properties

    private let restrictionsProvider = RestrictionsProvider()

    // MARK: - Functions

    func build(layer: SearchContentEnum, filters: Any?) -> FilterListModel? {
        switch layer {
        case .anime:
            guard let filters = filters as? AnimeListFilters else { return nil }
            return valuesProcessor(
                layer: layer,
                score: filters.score,
                kind: filters.kind?.rawValue,
                status: filters.status?.rawValue,
                genres: filters.genre,
                season: filters.season
            )
        case .manga:
            guard let filters = filters as? MangaListFilters else { return nil }
            return valuesProcessor(
                layer: layer,
                score: filters.score,
                kind: filters.kind?.rawValue,
                status: filters.status?.rawValue,
                genres: filters.genre,
                season: filters.season
            )
        case .ranobe:
            guard let filters = filters as? RanobeListFilters else { return nil }
            return valuesProcessor(
                layer: layer,
                score: filters.score,
                kind: filters.kind?.rawValue,
                status: filters.status?.rawValue,
                genres: filters.genre,
                season: filters.season
            )
        }
    }

    // MARK: - Private functions

    private func valuesProcessor(
        layer: SearchContentEnum,
        score: Int?,
        kind: String?,
        status: String?,
        genres: [Int]?,
        season: String?
    ) -> FilterListModel {
        let ratingList = processScore(score: score)
        let typeList = processKind(kind: kind)
        let statusList = processStatus(layer: layer, status: status)
        let genreList = processGenres(layer: layer, genres: genres)
        let seasonList = processSeasons(season: season)
        let years = processYears(season: season)
        let releaseYearStart = years.0
        let releaseYearEnd = years.1
        return FilterListModel(
            ratingList: ratingList,
            typeList: typeList,
            statusList: statusList,
            genreList: genreList,
            seasonList: seasonList,
            releaseYearStart: releaseYearStart,
            releaseYearEnd: releaseYearEnd
        )
    }

    private func processKind(kind: String?) -> String {
        guard let kind else { return "" }
        return Constants.kindsDictionary[kind] ?? ""
    }

    private func processStatus(layer: SearchContentEnum, status: String?) -> String {
        guard let status else { return "" }
        let dictionary = layer == .anime ? Constants.animeStatusDictionary : Constants.mangaStatusDictionary
        return dictionary[status] ?? ""
    }

    private func processGenres(layer: SearchContentEnum, genres: [Int]?) -> String {
        return restrictionsProvider.filterGenres(layer: layer, genres: genres)
    }

    private func processScore(score: Int?) -> String {
        guard let score else { return "" }
        return "\(score)"
    }

    private func processYears(season: String?) -> (String, String) {
        guard let season else { return ("", "") }
        let seasons = season.split(separator: ",")
        var startYearString = ""
        var endYearString = ""
        for item in seasons {
            let items = item.split(separator: "_").map { String($0) }
            if checkSeasonType(items: items) == .years {
                let years = processYearsRange(items: items)
                startYearString = years.0
                endYearString = years.1
                break
            }
        }
        return (startYearString, endYearString)
    }

    private func processSeasons(season: String?) -> String {
        guard let season else { return "" }
        let seasons = season.split(separator: ",")
        var seasonString = ""
        for item in seasons {
            let items = item.split(separator: "_").map { String($0) }
            if checkSeasonType(items: items) == .season {
                seasonString += processSeason(items: items) + ","
            }
        }
        return String(seasonString.dropLast())
    }

    private func checkSeasonType(items: [String]) -> SeasonType {
        if items.count == 2, Int(items.last ?? "") != nil {
            if Seasons.allCases.map({ $0.value }).contains(items.first) { return .season }
            if Int(items.first ?? "") != nil { return .years }
        }
        return .unknown
    }

    private func processSeason(items: [String]) -> String {
        let season = Seasons.allCases.first(where: { $0.value == items.first })?.rawValue ?? ""
        let year = items.last ?? ""
        return "\(season) \(year)"
    }

    private func processYearsRange(items: [String]) -> (String, String) {
        let startYear = Int(items.first ?? "") ?? Int.min
        let endYear = Int(items.last ?? "") ?? Int.max
        var startYearString = ""
        var endYearString = ""
        if startYear > Constants.Dates.startYearForFilter { startYearString = "\(startYear)" }
        if endYear < Date().getRelativeYear(10) { endYearString = "\(endYear)" }
        return (startYearString, endYearString)
    }
}

// MARK: - SeasonType

enum SeasonType {
    case unknown
    case season
    case years
}
