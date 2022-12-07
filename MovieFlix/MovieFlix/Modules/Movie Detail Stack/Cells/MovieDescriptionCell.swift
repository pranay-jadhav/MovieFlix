//
//  MovieDescriptionCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class MovieDescriptionCell: UITableViewCell {
    
    @IBOutlet private weak var movieDescription: UILabel!
    
    /// Configure description cell
    func configureCell(description: String) {
        selectionStyle = .none
        movieDescription.text = description
    }
}
