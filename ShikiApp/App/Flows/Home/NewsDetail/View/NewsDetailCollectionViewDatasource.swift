//
//  NewsDetailCollectionViewDatasource.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 24.01.2023.
//

import UIKit

final class NewsDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Private properties
    
    private let images: [UIImage]
    
    // MARK: - Init
    
    init(images: [UIImage]) {
        self.images = images
    }
    
    // MARK: - Methods
    
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
