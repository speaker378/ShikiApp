//
//  AppCollectionView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 03.02.2023.
//

import UIKit

final class AppCollectionView: UICollectionView {

    // MARK: - Private properties
    
    private enum Layout {
        static let itemWidth: CGFloat = 200
        static let itemHeight: CGFloat = 120
    }
    
    private let contents: [String]
    private var tapHandler: ((_ content: String) -> Void)?
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.Spacing.medium
        layout.itemSize = CGSize(width: Layout.itemWidth, height: Layout.itemHeight)
        return layout
    }()

    // MARK: - Construction
    
    init(imageURLStrings: [String]) {
        contents = imageURLStrings
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions
    
    func configureTapHandler(completion: @escaping (_ content: String) -> Void) {
        tapHandler = completion
    }
    
    // MARK: - Private functions
    
    private func configure() {
        dataSource = self
        delegate = self
        registerCell(AppCollectionViewCell.self)
        configureUI()
    }
    
    private func configureUI() {
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Layout.itemHeight).isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension AppCollectionView: UICollectionViewDataSource {

    // MARK: - Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            !contents.isEmpty,
            contents.indices.contains(indexPath.item),
            let cell: AppCollectionViewCell = collectionView.cell(forRowAt: indexPath)
        else { return UICollectionViewCell() }
        cell.configure(content: contents[indexPath.item])
        return cell
    }
}

extension AppCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        let URLString = contents[indexPath.row]
        tapHandler?(URLString)
    }
}
