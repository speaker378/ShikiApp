//
//  RestrictionsProvider.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 15.03.2023.
//

import Foundation

// MARK: - RestrictionsProvider

final class RestrictionsProvider {

    // MARK: - Properties

    static var restrictions: ContentRestrictionsProviderProtocol = ContentRestrictionsProvider()

    // MARK: - Private properties

    private static var censoredGenres: [SearchContentEnum: [Int]] = [:]
    private static var genresDictionary: [SearchContentEnum: [GenreModel]] = [:]

    // MARK: - Constructions

    init() {
        if Self.genresDictionary.isEmpty {
            ApiFactory.makeGenresApi().getList { data, _ in
                let factory = GenreModelFactory()
                let censored = Constants.censoredGenres.map { $0.lowercased() }
                Self.genresDictionary[.anime] = factory.build(genres: data, layer: .anime)
                Self.genresDictionary[.manga] = factory.build(genres: data, layer: .manga)
                Self.genresDictionary[.ranobe] = factory.build(genres: data, layer: .ranobe)
                let genres = data?.filter { censored.contains($0.name.lowercased()) }
                Self.censoredGenres[.anime] = factory.build(genres: genres, layer: .anime).map { $0.id }
                Self.censoredGenres[.manga] = factory.build(genres: genres, layer: .manga).map { $0.id }
                Self.censoredGenres[.ranobe] = factory.build(genres: genres, layer: .ranobe).map { $0.id }
            }
        }
    }
    
    static func addObserver(observer: @escaping (Bool) -> Void) {
        restrictions.addObserver(observer: observer)
    }
    
    func getGenres(layer: SearchContentEnum) -> [String] {
        var genres = Self.genresDictionary[layer]
        if Self.restrictions.isCensored(), let censored = Self.censoredGenres[layer] {
            genres?.removeAll(where: {censored.contains($0.id)})
        }
        return genres?.map { $0.name } ?? []
    }
    
    func filterGenres(layer: SearchContentEnum, genres: [Int]?) -> String {
        
        var genresString = ""
        guard let genresList = Self.genresDictionary[layer], var censoredGenres = genres else { return genresString }
        if Self.restrictions.isCensored(), let censored = Self.censoredGenres[layer] {
            censoredGenres.removeAll(where: {censored.contains($0)})
        }
        for genre in censoredGenres {
            if let name = genresList.first(where: { $0.id == genre })?.name {
                genresString += "\(name),"
            }
        }
        return String(genresString.dropLast())
    }
    
    func filterGenres(layer: SearchContentEnum, genres: [Int]?) -> [Int]? {
        guard var censoredGenres = genres else { return nil }
        if let censored = Self.censoredGenres[layer] {
            censoredGenres.removeAll(where: {censored.contains($0)})
        }
        return censoredGenres
    }
    func filterGenres(layer: SearchContentEnum, genres: String) -> [Int]? {
        if genres.isEmpty { return nil }
        var genresArray = [Int]()
        let genresList = genres.split(separator: ",")
        for element in genresList {
            if let genreId = Self.genresDictionary[layer]?.first(where: {$0.name == element})?.id {
                genresArray.append(genreId)
            }
        }
        if Self.restrictions.isCensored(), let censored = Self.censoredGenres[layer] {
            genresArray.removeAll(where: {censored.contains($0)})
        }
        return genresArray
    }
}
