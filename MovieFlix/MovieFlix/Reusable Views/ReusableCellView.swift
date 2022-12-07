//
//  ReusableCellView.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import Foundation

/// Defines a reusable table view or collection view cell.
public protocol ReusableCellView: AnyObject {

    /// Default reuse identifier is set with the class name.
    static var reuseIdentifier: String { get }

}

public extension ReusableCellView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
