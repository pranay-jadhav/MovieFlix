//
//  RatingsCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class RatingsCell: UICollectionViewCell {
    
    @IBOutlet private weak var filledRatingsStack: UIStackView!
    @IBOutlet private weak var emptyRatingsStack: UIStackView!
    @IBOutlet private weak var ratingsView: UIView!
    
    /// Configure ratings cell for Search screen
    func configureCell(index: Int, isSelected: Bool) {
        ratingsView.layer.borderColor = isSelected ? MFTheme.shared.orange.cgColor : UIColor.white.cgColor
        emptyRatingsStack.isHidden = isSelected
        
        filledRatingsStack.subviews.forEach({ $0.isHidden = true })
        emptyRatingsStack.subviews.forEach({ $0.isHidden = true })
        let totalStars = 5 - index
        for i in 0..<totalStars {
            filledRatingsStack.subviews[i].isHidden = false
            emptyRatingsStack.subviews[i].isHidden = false
        }
        
    }
}
