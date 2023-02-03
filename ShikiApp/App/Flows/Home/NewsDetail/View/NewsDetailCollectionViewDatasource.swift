//
//  NewsDetailCollectionViewDatasource.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 24.01.2023.
//

import UIKit

final class NewsDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    // MARK: - Private properties
    
    private let images: [UIImage?]

    // MARK: - Construction
    
    init(images: [UIImage?]) {
        self.images = images
    }

    // MARK: - Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            !images.isEmpty,
            images.indices.contains(indexPath.item),
            let cell: NewsDetailCollectionViewCell = collectionView.cell(forRowAt: indexPath)
        else { return UICollectionViewCell() }
        cell.configure(image: images[indexPath.item] ?? UIImage())
        return cell
    }
}
