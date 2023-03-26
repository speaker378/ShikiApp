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

final class UserRatesModelFactory {
    
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
        let kind = extractKind(kind: source.kind)
        
        let watchingEpisodes = extracWatchingEpisodes(
            watchedEpisodes: ratesList?.episodes ?? 0,
            chaptersRead: ratesList?.chapters ?? 0,
            episodesAired: source.episodesAired ?? 0,
            episodesUnderShot: source.episodes ?? 0,
            chapters: source.chapters ?? 0,
            contentKind: source.kind ?? ""
        )
        
        let totalEpisodes = extracWatchingEpisodes(
            totalEpisodes: source.episodes ?? 0,
            totalChapters: source.chapters ?? 0,
            contentKind: source.kind ?? ""
        )
        
        let score = Score(
            value: extractScore(score: source.score),
            color: extractScoreColor(score: source.score)
        )
        let status = extractStatus(score: ratesList?.status)
        let statusImage = extractImageStatus(score: ratesList?.status)
        let ongoingStatus = extractStatus(status: source.status, contentKind: kind)
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
            status: status,
            statusImage: statusImage,
            episodes: episodes,
            rewatches: rewatches,
            chapters: chapters,
            volumes: volumes
        )
    }
    
    private func extractUrlString(image: ImageDTO?) -> String {
        
        guard let image else { return "" }
        return "\(Constants.Url.baseUrl)\(image.preview)"
    }
    
    private func extractKind(kind: String?) -> String {
        
        guard let kind,
              let kindDescription = Constants.kindsDictionary[kind]
        else { return "" }
        return kindDescription
    }
    
    private func extractStatus(score: String?) -> String {
        guard let score else { return ""}
        
        return Constants.watchingStatuses[score] ?? ""
    }
    
    private func extractImageStatus(score: String?) -> UIImage {
        guard let score else { return UIImage() }
        
        return Constants.watchingImageStatuses[score] ?? UIImage()
    }
    
    private func extractScore(score: String?) -> String {
        
        guard let score,
              let floatScore = Float(score) else { return "" }
        return String(format: "%.1f", floatScore)
    }
    
    private func extractScoreColor(score: String?) -> UIColor {
        
        Constants.scoreColors[score?.first ?? " "] ?? AppColor.line
    }
    
    private func extracWatchingEpisodes(watchedEpisodes: Int, chaptersRead: Int, episodesAired: Int, episodesUnderShot: Int, chapters: Int, contentKind: String) -> String {
        let delimiter = "·"
        var episodes = ""
        var watched = ""
        let isManga = MangaContentKind.allCases.map { $0.rawValue }.contains(contentKind)
        
        if isManga {
            watched = String(describing: chaptersRead)
            
            if chapters > 0 {
                episodes = String(describing: chapters)
            } else {
                episodes = "?"
            }
        } else {
            watched = String(describing: watchedEpisodes)
            
            if episodesAired > 0 {
                episodes = String(describing: episodesAired)
            } else if episodesAired == 0 {
                if episodesUnderShot > 0 {
                    episodes = String(describing: episodesUnderShot)
                } else {
                    episodes = "?"
                }
            }
        }
        
        return "\(watched)/\(episodes) \(delimiter) "
    }
    
    private func extracWatchingEpisodes(totalEpisodes: Int, totalChapters: Int, contentKind: String) -> String {
        var total = ""
        let isManga = MangaContentKind.allCases.map { $0.rawValue }.contains(contentKind)
        
        if isManga {
            total = "\(Texts.OtherMessage.total) \(String(describing: totalChapters)) \(Texts.OtherMessage.chapters)"
            
        } else {
            total = "\(Texts.OtherMessage.total) \(String(describing: totalEpisodes)) \(Texts.OtherMessage.episodes)"
        }
        
        return total
    }
    
    private func extractStatus(status: String?, contentKind: String?) -> String {
        guard let status, let contentKind else { return "" }
        let isManga = MangaContentKind.allCases.map { $0.rawValue }.contains(contentKind)
        return isManga ? Constants.mangaStatuses[status] ?? "" : Constants.animeStatuses[status] ?? ""
    }
}
