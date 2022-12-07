//
//  MovieTitleViewModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import UIKit

//MARK: - Movie title model
struct MovieTitleModel {
    
    var imageURL: String
    var releaseDateAndTime: String
    var moveTitle: String
    var moviewRating: Int
    var genre: [String]
    
    init(dataModel: MFMovie) {
        self.imageURL = dataModel.posterURL
        let durationHrs = dataModel.runtime / 60
        let durationMins = dataModel.runtime % 60
        let releaseYear = dataModel.releaseDate.split(separator: "-").first ?? ""
        self.releaseDateAndTime = "\(releaseYear) . \(durationHrs)h \(durationMins)m"
        self.moveTitle = dataModel.title
        self.moviewRating = Int(dataModel.rating.rounded())
        self.genre = dataModel.genres
    }
}
