//
//  FiltersModel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 14.02.2023.
//

import Foundation

// MARK: - FiltersModel

struct FiltersModel {
    var ratingList: [String]
    var typeList: [String]
    var statusList: [String]
    var genreList: [String]
    var seasonList: [String]
}

// MARK: - FiltersModelFactory

final class FiltersModelFactory {

    // MARK: - Private properties

    private let types: [SearchContentEnum: [String]] = [
        .anime: AnimeFilterKinds.descriptions,
        .manga: MangaFilterKinds.descriptions,
        .ranobe: RanobeFilterKinds.descriptions
    ]
    private let statuses: [SearchContentEnum: [String]] = [
        .anime: AnimeFilterStatus.descriptions,
        .manga: MangaFilterStatus.descriptions,
        .ranobe: RanobeFilterStatus.descriptions
    ]
    private var seasons: [SeasonModel] = []
    private var processors: [SearchContentEnum: (_: FilterListModel) -> Any] = [:]
    private var genres: [SearchContentEnum: [GenreModel]] = [:]

    // MARK: - Constructions

    init() {
        if genres.isEmpty {
            ApiFactory.makeGenresApi().getList { data, _ in
                let factory = GenreModelFactory()
                self.genres[.anime] = factory.build(genres: data, layer: .anime)
                self.genres[.manga] = factory.build(genres: data, layer: .manga)
                self.genres[.ranobe] = factory.build(genres: data, layer: .ranobe)
            }
        }
        seasons = SeasonModelFactory().build()
        processors = [
            .anime: buildAnimeFilter,
            .manga: buildMangaFilter,
            .ranobe: buildRanobeFilter
        ]
    }

    // MARK: - Functions

    func buildFiltersModel(layer: SearchContentEnum) -> FiltersModel {
        return FiltersModel(
            ratingList: Ratings.descriptions,
            typeList: types[layer] ?? [],
            statusList: statuses[layer] ?? [],
            genreList: genres[layer]?.map { $0.name } ?? [],
            seasonList: seasons.map { $0.description }
        )
    }

    func buildFilter(filters: FilterListModel, layer: SearchContentEnum) -> Any? {
        guard let processor = processors[layer], !filters.isEmpty() else { return nil }
        return processor(filters)
    }

    // MARK: - Private functions

    private func buildAnimeFilter(filters: FilterListModel) -> AnimeListFilters {
        let kind = processAnimeKind(kindDescription: filters.typeList)
        let status = processAnimeStatus(statusDescription: filters.statusList)
        let score = processScore(scoreDescription: filters.ratingList)
        let season = processSeason(
            startYear: filters.releaseYearStart,
            endYear: filters.releaseYearEnd,
            season: filters.seasonList
        )
        let genres = processGenres(genresString: filters.genreList, layer: .anime)
        return AnimeListFilters(kind: kind, status: status, season: season, score: score, genre: genres)
    }
    
    private func buildMangaFilter(filters: FilterListModel) -> MangaListFilters {
        let kind = processMangaKind(kindDescription: filters.typeList)
        let status = processMangaStatus(statusDescription: filters.statusList)
        let score = processScore(scoreDescription: filters.ratingList)
        let season = processSeason(
            startYear: filters.releaseYearStart,
            endYear: filters.releaseYearEnd,
            season: filters.seasonList
        )
        let genres = processGenres(genresString: filters.genreList, layer: .manga)
        return MangaListFilters(kind: kind, status: status, season: season, score: score, genre: genres)
    }
    
    private func buildRanobeFilter(filters: FilterListModel) -> RanobeListFilters {
        let kind = processRanobeKind(kindDescription: filters.typeList)
        let status = processRanobeStatus(statusDescription: filters.statusList)
        let score = processScore(scoreDescription: filters.ratingList)
        let season = processSeason(
            startYear: filters.releaseYearStart,
            endYear: filters.releaseYearEnd,
            season: filters.seasonList
        )
        let genres = processGenres(genresString: filters.genreList, layer: .ranobe)
        return RanobeListFilters(kind: kind, status: status, season: season, score: score, genre: genres)
    }
    
    private func processSeason(startYear: String, endYear: String, season: String) -> String? {
        if startYear.isEmpty, endYear.isEmpty, season.isEmpty { return nil }
        var seasonValue: String = ""
        let seasons = season.split(separator: ",").map { $0.split(separator: " ") }
        for element in seasons {
            if let season = Seasons
                .allCases
                .first(where: { $0.rawValue == element.first ?? ""})?
                .value,
               let year = element.last {
                seasonValue.append("\(season)_\(year),")
            }
        }
        if !startYear.isEmpty || !endYear.isEmpty {
            let initialYear = startYear.isEmpty ? "\(Constants.Dates.startYearForFilter)" : startYear
            let finalYear = endYear.isEmpty ? "\(Date().getRelativeYear(1))" : endYear
            seasonValue.append("\(initialYear)_\(finalYear),")
        }
        seasonValue.removeLast()
        return seasonValue
    }
    
    private func processScore(scoreDescription: String) -> Int? {
        return Int(scoreDescription)
    }
    
    private func processAnimeKind(kindDescription: String) -> AnimeContentKind? {
        let kindValue = Constants.kindsDictionary
            .first(where: { $0.value == kindDescription })
            .map { $0.key }
        return AnimeContentKind.allCases.first(where: { $0.rawValue == kindValue })
    }
    
    private func processMangaKind(kindDescription: String) -> MangaContentKind? {
        let kindValue = Constants.kindsDictionary
            .first(where: { $0.value == kindDescription })
            .map { $0.key }
        return MangaContentKind.allCases.first(where: { $0.rawValue == kindValue })
    }
    
    private func processRanobeKind(kindDescription: String) -> RanobeContentKind? {
        let kindValue = Constants.kindsDictionary
            .first(where: { $0.value == kindDescription })
            .map { $0.key }
        return RanobeContentKind.allCases.first(where: { $0.rawValue == kindValue })
    }
    
    private func processAnimeStatus(statusDescription: String) -> AnimeContentStatus? {
        let statusValue = Constants.animeStatusDictionary
            .first(where: { $0.value == statusDescription })
            .map { $0.key }
        return AnimeContentStatus.allCases.first(where: { $0.rawValue == statusValue })
    }
    
    private func processMangaStatus(statusDescription: String) -> MangaContentStatus? {
        let statusValue = Constants.mangaStatusDictionary
            .first(where: { $0.value == statusDescription })
            .map { $0.key }
        return MangaContentStatus.allCases.first(where: { $0.rawValue == statusValue })
    }
    
    private func processRanobeStatus(statusDescription: String) -> RanobeContentStatus? {
        let statusValue = Constants.mangaStatusDictionary
            .first(where: {$0.value == statusDescription})
            .map { $0.key }
        return RanobeContentStatus.allCases.first(where: { $0.rawValue == statusValue })
    }
    
    private func processGenres(genresString: String, layer: SearchContentEnum) -> [Int]? {
        if genresString.isEmpty { return nil }
        var genresArray = [Int]()
        let genresList = genresString.split(separator: ",")
        for element in genresList {
            if let genreId = genres[layer]?.first(where: {$0.name == element})?.id {
                genresArray.append(genreId)
            }
        }
        return genresArray
    }
}
