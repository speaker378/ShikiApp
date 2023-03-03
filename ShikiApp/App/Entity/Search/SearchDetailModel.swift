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
}

final class SearchDetailModelFactory {
    
    func makeDetailModel(from source: SearchDetailContentProtocol) -> SearchDetailModel {
        let service = SearchModelInfoService()
        let delimiter = "·"
        let title = service.extractTitle(name: source.name, russian: source.russian)
        let urlString = service.extractUrlString(image: source.image)
        let airedReleasedDates = service.extractYears(
            airedOn: source.airedOn,
            releasedOn: source.releasedOn,
            kind: source.kind
        )
        let episodesText = service.makeEpisodesText(
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            kind: source.kind,
            status: source.status
        )
        let genres = service.extractGenres(source.genres)
        let kind = service.extractKind(source.kind)
        let kindAndDate = "\(kind) \(delimiter) \(airedReleasedDates)"
        let status = service.extractStatus(status: source.status, kind: source.kind)
        let rating = service.extractRating(source.rating)
        let score = service.extractScore(source.score)
        let studios = service.extractStudios(studios: source.studios, publishers: source.publishers)
        let duration = service.extractDuration(
            duration: source.duration,
            volumes: source.volumes,
            chapters: source.chapters
        )
        let rateList = service.makeRatesList(kind: source.kind, status: source.status)
        
        return SearchDetailModel(
            id: source.id,
            imageUrlString: urlString,
            title: title,
            kind: kind,
            kindAndDate: kindAndDate,
            score: score,
            status: status,
            description: source.description?.removeTags() ?? Texts.Empty.noDescription,
            rating: rating,
            studios: studios,
            genres: genres,
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            episodesText: episodesText,
            volumes: source.volumes,
            chapters: source.chapters,
            duration: source.duration,
            durationOrVolumes: duration,
            rateList: rateList
        )
    }
}
