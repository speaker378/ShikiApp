//
//  GenreModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 21.02.2023.
//

import Foundation

// MARK: - GenreModel

struct GenreModel {
    let id: Int
    let name: String
}

// MARK: - GenreModelFactory

final class GenreModelFactory {

    // MARK: - Functions

    func build(genres: GenreResponseDTO?, layer: SearchContentEnum) -> [GenreModel] {
        guard let genres else { return [] }
        return genres
            .filter { $0.kind == layer.genresFilter }
            .map { GenreModel(id: $0.id, name: $0.russian ?? $0.name) }
            .sorted(by: {$0.name < $1.name})
    }
}
