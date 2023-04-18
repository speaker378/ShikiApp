//
//  UserRatesModel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

// MARK: - UserRatesModel

struct UserRatesModel {
    
    let id: Int
    let target: String
    let imageUrlString: String
    let title: String
    let kind: String
    let ongoingStatus: String
    let watchingEpisodes: String
    let totalEpisodes: String
    let score: Score
    let status: String
    let statusImage: UIImage
    let episodes: Int?
    let rewatches: Int?
    let chapters: Int?
    let volumes: Int?
    
}

// MARK: - UserRatesModelFactory

final class UserRatesModelFactory: PrepareInfoProtocol {
    
    private var ratesList: UserRatesResponseDTO = []

    // MARK: - Functions

    func makeModels(from source: [UserRatesContentProtocol], ratesList: UserRatesResponseDTO) -> [UserRatesModel] {
        self.ratesList = ratesList
        return source.compactMap(self.viewModel)
    }

    // MARK: - Private functions

    private func viewModel(from source: UserRatesContentProtocol) -> UserRatesModel {
        let ratesList = ratesList.first(where: {$0.targetID == source.id})
        let id = source.id
        let target = ratesList?.targetType ?? ""
        let urlString = extractUrlString(image: source.image)
        let title = source.russian ?? source.name
        let kind = extractKind(source.kind)
        
        let watchingEpisodes = extractWatchingEpisodes(
            watchedEpisodes: ratesList?.episodes ?? 0,
            chaptersRead: ratesList?.chapters ?? 0,
            episodesAired: source.episodesAired ?? 0,
            episodesUnderShot: source.episodes ?? 0,
            chapters: source.chapters ?? 0,
            contentKind: source.kind ?? ""
        )
        
        let totalEpisodes = extractWatchingEpisodes(
            totalEpisodes: source.episodes ?? 0,
            totalChapters: source.chapters ?? 0,
            contentKind: source.kind ?? ""
        )
        
        let score = Score(
            value: extractScore(source.score),
            color: extractScoreColor(source.score)
        )
        let watchingStatus = extractWatchingStatus(score: ratesList?.status)
        let statusImage = extractImageStatus(score: ratesList?.status)
        let ongoingStatus = extractStatus(status: source.status, kind: kind)
        let episodes = ratesList?.episodes
        let rewatches = ratesList?.rewatches
        let chapters = ratesList?.chapters
        let volumes = ratesList?.volumes
        
        
        return UserRatesModel(
            id: id,
            target: target,
            imageUrlString: urlString,
            title: title,
            kind: kind,
            ongoingStatus: ongoingStatus,
            watchingEpisodes: watchingEpisodes,
            totalEpisodes: totalEpisodes,
            score: score,
            status: watchingStatus,
            statusImage: statusImage,
            episodes: episodes,
            rewatches: rewatches,
            chapters: chapters,
            volumes: volumes
        )
    }
}
