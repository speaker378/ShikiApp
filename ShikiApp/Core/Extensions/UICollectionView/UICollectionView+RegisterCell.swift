//
//  UICollectionView+RegisterCell.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
// Класс для регистрации ячейки в коллекции
// Пример использования:
//  collectionView.registerClass(MyCollectionViewCell.self)
//  collectionView.registerHeader(MyHeaderViewCell.self)
//  collectionView.registerFooter(MyFooterViewCell.self)
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//   guard let cell: MyCollectionViewCell = collectionView.cell(forRowAt: indexPath) else { return UICollectionViewCell() }
//
//     [code]

//   return cell
//  }

import UIKit

protocol ReusableCellIdentifiable {
    static var cellIdentifier: String { get }
}

protocol ReusableHeaderFooterCellIdentifiable: AnyObject {
    static var cellIdentifier: String { get }
}

extension UICollectionView {
    
    enum SupplementaryViewKind {
        case header
        case footer
        
        var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass.self,
                 forCellWithReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func registerHeader<T: UICollectionReusableView>(_ header: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.cellIdentifier)
    }
    
    func registerFooter<T: UICollectionReusableView>(_ footer: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.cellIdentifier)
    }
    
    func cell<T: ReusableCellIdentifiable>(forRowAt indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as? T
    }
    
    func cell<T: ReusableCellIdentifiable>(forClass cellClass: T.Type, _ indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as? T
    }
    
    func cellFooterHeader<T: ReusableHeaderFooterCellIdentifiable>(ofKind kind: SupplementaryViewKind,
                                                                   forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.cellIdentifier,
                                                for: indexPath) as? T
    }
    
}

extension UICollectionViewCell: ReusableCellIdentifiable {}

extension UICollectionReusableView: ReusableHeaderFooterCellIdentifiable {}

extension ReusableCellIdentifiable where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension ReusableHeaderFooterCellIdentifiable where Self: UICollectionReusableView {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
