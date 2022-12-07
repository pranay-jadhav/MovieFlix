//
//  MovieTitleCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class MovieTitleCell : UITableViewCell {
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var ratingsStack: UIStackView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    
    /// Configure Movie title cell
    func configureCell(viewModel: MovieTitleModel) {
        selectionStyle = .none
        shadowView.dropShadow()
        movieImageView.downloadImage(from: viewModel.imageURL)
        releaseDateLabel.text = viewModel.releaseDateAndTime
        movieTitleLabel.text = viewModel.moveTitle
        ratingsStack.subviews.forEach({ $0.isHidden = true })
        for i in 0..<viewModel.moviewRating {
            ratingsStack.subviews[i].isHidden = false
        }
    }
}
