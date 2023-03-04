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
    let kind: String?
    let episodes: Int
    let rewatched: Int
    let chapters: Int
    let volumes: Int
    let score: Int
    let status: String
}

final class SearchDetailModelFactory {
    
    func makeDetailModel(from source: SearchDetailContentProtocol) -> SearchDetailModel {
        let service = SearchModelInfoService()
        let delimiter = "·"
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
        let kind = service.extractKind(source.kind)
        let duration = service.extractDuration(
            duration: source.duration,
            volumes: source.volumes,
            chapters: source.chapters
        )
        
        return SearchDetailModel(
            id: source.id,
            imageUrlString: service.extractUrlString(image: source.image),
            title: service.extractTitle(name: source.name, russian: source.russian),
            kind: kind,
            kindAndDate: "\(kind) \(delimiter) \(airedReleasedDates)",
            score: service.extractScore(source.score),
            status: service.extractStatus(status: source.status, kind: source.kind),
            description: source.description?.removeTags() ?? Texts.Empty.noDescription,
            rating: service.extractRating(source.rating),
            studios: service.extractStudios(studios: source.studios, publishers: source.publishers),
            genres: service.extractGenres(source.genres),
            episodes: source.episodes,
            episodesAired: source.episodesAired,
            episodesText: episodesText,
            volumes: source.volumes,
            chapters: source.chapters,
            duration: source.duration,
            durationOrVolumes: duration,
            rateList: service.makeRatesList(kind: source.kind, status: source.status),
            userRate: service.extractUserRate(source.userRate, targetID: source.id, kind: source.kind)
        )
    }
}
