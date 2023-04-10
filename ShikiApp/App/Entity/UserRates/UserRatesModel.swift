//
//  UserRatesModel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

// MARK: - UserRatesModel

final class UserRatesModel {
    
    let targetID: Int
    let target: String
    let imageUrlString: String
    let title: String
    let kind: String
    let ongoingStatus: String
    let watchingEpisodes: String
    let totalEpisodes: String
    var score: Score
    var status: String
    let statusImage: UIImage
    var episodes: Int?
    var rewatches: Int?
    var chapters: Int?
    var volumes: Int?
    var userRateID: Int // нужно для апдейта и удаление списка
    
    init(targetID: Int, target: String, imageUrlString: String, title: String, kind: String, ongoingStatus: String, watchingEpisodes: String, totalEpisodes: String, score: Score, status: String, statusImage: UIImage, episodes: Int? = nil, rewatches: Int? = nil, chapters: Int? = nil, volumes: Int? = nil, userRateID: Int = 0) {
        self.targetID = targetID
        self.target = target
        self.imageUrlString = imageUrlString
        self.title = title
        self.kind = kind
        self.ongoingStatus = ongoingStatus
        self.watchingEpisodes = watchingEpisodes
        self.totalEpisodes = totalEpisodes
        self.score = score
        self.status = status
        self.statusImage = statusImage
        self.episodes = episodes
        self.rewatches = rewatches
        self.chapters = chapters
        self.volumes = volumes
        self.userRateID = userRateID
    }
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
            targetID: id,
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
            userRateID: 0
        )
    }
}
