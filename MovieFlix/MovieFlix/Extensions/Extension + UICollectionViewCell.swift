//
//  Extension + UICollectionViewCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import UIKit

/// Conformance to ReusableCellView Protocol
extension UICollectionViewCell: ReusableCellView { }

/// Helper methods for CollectionView
public extension UICollectionView {

    /// Dequeues a reusable collection view cell.
    ///
    /// - Parameter indexPath: The index path to use.
    /// - Returns: The collection view cell.
    func dequeueReusableCell<T: ReusableCellView>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("No collection view cell could be dequeued with identifier \(T.reuseIdentifier)")
        }

        return cell
    }

    /// Registers the collection view cell based on the given identifier when the cell was created from a nib file.
    ///
    /// - Parameter cellIdentifier: The cell identifier to use.
    func registerCellFromNib(cellIdentifier: String) {
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }

    /// Registers the collection view cell based on the given identifier when the cell was created from manual layout.
    ///
    /// - Parameters:
    ///   - cellClass: The cell class to use.
    func registerCell<T: ReusableCellView>(cellClass: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
}
