//
//  NewsDetailContentView.swift
//  ShikiApp
//
//  Created by Alla Shkolnik on 24.01.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource

final class NewsDetailCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    private var images: [UIImage]
    
    init(images: [UIImage]) {
        self.images = images
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell: NewsDetailCollectionViewCell = collectionView.cell(forRowAt: indexPath),
            images.indices.contains(indexPath.item)
        else { return UICollectionViewCell() }
        cell.configure(image: images[indexPath.item])
        return cell
    }
}
