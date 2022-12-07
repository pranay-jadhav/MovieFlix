//
//  FavoriteCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet private weak var seeAllView: UIView!
    @IBOutlet private weak var movieImageSuperView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var actorNameView: UIView!
    @IBOutlet private weak var actorNameLabel: UILabel!
    @IBOutlet private weak var actorCharacterNameLabel: UILabel!
    
    /// Configure Normal cell
    func configureCell(movieModel: MFMovie) {
        seeAllView.isHidden = true
        actorNameView.isHidden = true
        movieImageSuperView.isHidden = false
        movieImageView.downloadImage(from: movieModel.posterURL)
    }
    
    /// Configure See all cell
    func configureSeeAllCell() {
        seeAllView.isHidden = false
        actorNameView.isHidden = true
        movieImageSuperView.isHidden = true
    }
    
    /// Configure cell for Director cell
    func configureCellForDirector(dataModel: MFMovie) {
        seeAllView.isHidden = true
        actorNameView.isHidden = false
        movieImageView.downloadImage(from: dataModel.director.pictureURL)
        actorNameLabel.text = dataModel.director.name
        actorCharacterNameLabel.text = ""
        
    }
    
    /// Configure cell for cast cell
    func configureCellForCast(cast: MFMovieCast) {
        seeAllView.isHidden = true
        actorNameView.isHidden = false
        movieImageView.downloadImage(from: cast.pictureURL)
        actorNameLabel.text = cast.name
        actorCharacterNameLabel.text = cast.character ?? ""
        
    }
}

