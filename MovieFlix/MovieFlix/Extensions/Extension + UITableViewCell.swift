//
//  Extension + UITableViewCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import UIKit

extension UITableViewCell: ReusableCellView { }

extension UITableViewHeaderFooterView: ReusableCellView { }

public extension UITableView {

    /// Dequeues a table view cell based on the given index path.
    ///
    /// - Parameter indexPath: The index path to use.
    /// - Returns: The table view cell.
    func dequeueReusableCellForIndex<T: ReusableCellView>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("No table view cell could be dequeued with identifier \(T.reuseIdentifier)")
        }
        return cell
    }

    /// Dequeues a table view header / footer
    ///
    /// - Parameter identifier: The view identifier
    func dequeueReusableHeaderFooter<T: ReusableCellView>(identifier: String) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("No table view view could be dequeued with identifier \(T.reuseIdentifier)")
        }
        return view
    }
    
    /// Registers the table view cell based on the given identifier from a nib file.
    ///
    /// - Parameter cellIdentifier: The cell identifier to use.
    func registerCellFromNib(cellIdentifier: String) {
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    /// Registers the table view cell based on the given identifier when the cell was created from manual layout.
    ///
    /// - Parameter cellClass: The cell class to use.
    func registerCell<T: ReusableCellView>(cellClass: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Registers header / footer to the table view
    ///
    /// - Parameter viewNibName: View nibname
    func registerNib(viewNibName: String) {
        let nibName = UINib(nibName: viewNibName, bundle: nil)
        register(nibName, forHeaderFooterViewReuseIdentifier: viewNibName)
    }
}
