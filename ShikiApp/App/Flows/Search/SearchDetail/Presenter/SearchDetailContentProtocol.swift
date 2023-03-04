//
//  SearchDetailContentProtocol.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 17.02.2023.
//
//

protocol SearchDetailContentProtocol {
    
    var id: Int { get }
    var name: String { get }
    var russian: String? { get }
    var image: ImageDTO? { get }
    var kind: String? { get }
    var score: String? { get }
    var airedOn: String? { get }
    var releasedOn: String? { get }
    var status: String? { get }
    var description: String? { get }
    var rating: String? { get }
    var studios: [StudioDTO] { get }
    var publishers: [PublisherDTO] { get }
    var genres: [GenreDTO] { get }
    var episodes: Int? { get }
    var episodesAired: Int? { get }
    var volumes: Int? { get }
    var chapters: Int? { get }
    var duration: Int? { get }
    var userRate: UserRatesDTO? { get }
 }

extension SearchDetailContentProtocol {
    
    var genres: [GenreDTO] { return [] }
    var studios: [StudioDTO] { return [] }
    var publishers: [PublisherDTO] { return [] }
    var rating: String? { return nil }
    var episodes: Int? { return nil }
    var episodesAired: Int? { return nil }
    var volumes: Int? { return nil }
    var chapters: Int? { return nil }
    var duration: Int? { return nil }
}
