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

final class UserRatesModelFactory {

    // MARK: - Functions

    func makeModels(from source: [UserRatesContentProtocol]) -> [UserRatesModel] {
        return source.compactMap(self.viewModel)
    }

    // MARK: - Private functions

    private func viewModel(from source: UserRatesContentProtocol) -> UserRatesModel {
        let delimiter = "·"
        let id = source.id
        let target = source.target
        let urlString = extractUrlString(image: source.image)
        let title = source.russian ?? source.name
        let kind = extractKind(kind: source.kind)
        let watchingEpisodes = "\(String(describing: source.watchingEpisodes ?? 0))/\(String(describing: source.totalEpisodes ?? 0)) \(delimiter) "
        let totalEpisodes = "Всего: \(String(describing: source.totalEpisodes ?? 0)) эп." // возьму из констант после мерджа с Аллой
        
        let score = Score(
            value: extractScore(score: source.score),
            color: extractScoreColor(score: source.score)
        )
        let status = extractStatus(score: source.status)
        let statusImage = extractImageStatus(score: source.status)
        let ongoingStatus = "Вышло" // изменю после мерджа с веткой Аллы, также добавлю цвета поля
        
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
            status: status,
            statusImage: statusImage,
            episodes: nil,
            rewatches: nil,
            chapters: nil,
            volumes: nil,
            userRateID: 0
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
        
        Constants.scoreColors[String(score?.first ?? " ")] ?? AppColor.line
    }
}
// TODO: - Для примера. Удалить, когда будет сетевой слой или база данных
final class UserRatesMock: UserRatesContentProtocol {
    var id: Int
    var name: String
    var target: String
    var russian: String?
    var image: ImageDTO?
    var kind: String?
    var score: String?
    var ongoingStatus: String?
    var status: String?
    var totalEpisodes: Int?
    var watchingEpisodes: Int?
    var episodes: Int?
    var rewatches: Int?
    var chapters: Int?
    var volumes: Int?
    
    init(
        id: Int,
        name: String,
        target: String,
        russian: String? = nil,
        image: ImageDTO? = nil,
        kind: String? = nil,
        score: String? = nil,
        ongoingStatus: String? = nil,
        status: String? = nil,
        totalEpisodes: Int? = nil,
        watchingEpisodes: Int? = nil,
        episodes: Int? = nil,
        rewatches: Int? = nil,
        chapters: Int? = nil,
        volumes: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.target = target
        self.russian = russian
        self.image = image
        self.kind = kind
        self.score = score
        self.ongoingStatus = ongoingStatus
        self.status = status
        self.totalEpisodes = totalEpisodes
        self.watchingEpisodes = watchingEpisodes
        self.episodes = episodes
        self.rewatches = rewatches
        self.chapters = chapters
        self.volumes = volumes
    }

}

struct UserRatesExample {
    
    let userRates = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Anime",
        russian: "Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "9",
        status: "completed",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
    let userRates1 = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Anime",
        russian: "Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "5",
        status: "planned",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
    let userRates2 = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Anime",
        russian: "Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "1",
        status: "watching",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
    let userRates3 = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Anime",
        russian: "Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "7",
        status: "on_hold",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
    let userRates4 = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Anime",
        russian: "Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "2",
        status: "dropped",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
    let userRates5 = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Anime",
        russian: "Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "8",
        status: "rewatching",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
    
    let userRates6 = UserRatesMock(
        id: 12292,
        name: "Higurashi no Naku Koro ni: Kokoroiyashi-hen",
        target: "Manga",
        russian: "Manga Когда плачут цикады: Глава об исцелении сердец",
        image: ImageDTO(
            original: "/system/mangas/original/12292.jpg?1648169019",
            preview: "/system/mangas/preview/12292.jpg?1648169019",
            x96: "/system/mangas/x96/12292.jpg?1648169019",
            x48: "/system/mangas/x48/12292.jpg?1648169019"
        ),
        kind: "tv",
        score: "7",
        status: "rewatching",
        totalEpisodes: 25,
        watchingEpisodes: 3
    )
}

final class UserRatesModelFactoryMoсk {
    let userRatesModelFactoryMoсk = UserRatesModelFactory().makeModels(
        from: [UserRatesExample().userRates,
               UserRatesExample().userRates1,
               UserRatesExample().userRates2,
               UserRatesExample().userRates3,
               UserRatesExample().userRates4,
               UserRatesExample().userRates5,
               UserRatesExample().userRates6
              ]
    )
}
