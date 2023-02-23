//
//  GenreViewModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 21.02.2023.
//

import Foundation

// MARK: - GenreViewModel

struct GenreViewModel {
    let id: Int
    let name: String
}

// MARK: - GenreModelFactory

final class GenreViewModelFactory {

    // MARK: - Functions

    func build(genres: GenreResponseDTO?, layer: SearchContentEnum) -> [GenreViewModel] {
        guard let genres else { return [] }
        return genres
            .filter { $0.kind == layer.genresFilter }
            .map { GenreViewModel(id: $0.id, name: $0.russian ?? $0.name) }
            .sorted(by: {$0.name < $1.name})
    }
}
