//
//  VideoModel.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 01.04.2023.
//

import Foundation

// MARK: - VideoModel

struct VideoModel {
    let url: String?
    let name: String?
}

// MARK: - VideoModelFactory

final class VideoModelFactory {

    // MARK: - Functions

    func makeModels(from source: [VideoDTO]) -> [VideoModel] {
        return source.map { makeVideoModel(from: $0) }
    }

    // MARK: - Private functions

    private func makeVideoModel(from source: VideoDTO) -> VideoModel {
            
        return VideoModel(
            url: source.imageUrl,
            name: source.name
        )
    }
}
