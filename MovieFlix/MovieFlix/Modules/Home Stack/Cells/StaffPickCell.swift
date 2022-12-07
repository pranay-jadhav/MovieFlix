//
//  StaffPickCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import UIKit

protocol StaffPickCellDelegate: AnyObject {
    func updateBookMarkStatus()
}

class StaffPickCell: UITableViewCell {
    
    @IBOutlet private weak var movieBannerImageView: UIImageView!
    @IBOutlet private weak var movieReleaseYearLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieRatingsView: UIStackView!
    @IBOutlet private weak var bookmarkedImageView: UIImageView!
    
    weak var delegate: StaffPickCellDelegate?
    
    private var cellViewModel: StaffPickViewModel?
    
    /// Configure cell for Staff picks on home and seacrh screen
    func configureCell(viewModel: StaffPickViewModel) {
        let dataModel = viewModel.getDataModel()
        self.cellViewModel = viewModel
        selectionStyle = .none
        movieBannerImageView.downloadImage(from: dataModel.posterURL)
        movieReleaseYearLabel.text = String(dataModel.releaseDate.split(separator: "-").first ?? "")
        movieTitleLabel.text = dataModel.title
        bookmarkedImageView.image = dataModel.isBookMarked ? UIImage(named: "yellowWhiteBookmark") : UIImage(named: "whiteBookMark")
        movieRatingsView.subviews.forEach({ ($0 as? UIImageView)?.image = UIImage(named: "greyStar") })
        let totalStars = Int(dataModel.rating.rounded())
        for i in 0..<totalStars {
            (movieRatingsView.subviews[i] as? UIImageView)?.image = UIImage(named: "filledStar")
        }
    }
    
    @IBAction func bookMarkAction(_ sender: Any) {
        self.cellViewModel?.updateBookMarkStatus()
        self.delegate?.updateBookMarkStatus()
    }
}
