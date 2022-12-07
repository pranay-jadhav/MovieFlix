//
//  MFMovieDetailViewModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

//MARK: - Sections on detail screen
enum MovieDetailsSection: String, CaseIterable {
    case header = ""
    case overview = "Overview"
    case directorSection = "Director"
    case actorSection = "Actor"
    case keyFactsSection = "Key Facts"
}

class MFMovieDetailViewModel {
    
    private var movieDetails: MFMovie
    private var sections = [MovieDetailsSection]()
    
    init(movieDetails: MFMovie) {
        self.movieDetails = movieDetails
    }
    
    //MARK: - Data Helpers
    func getBookMarkStatus() -> UIImage {
        return movieDetails.isBookMarked ? UIImage(named: "blueFillCheckMark")! : UIImage(named: "blueEmptyCheckmar")!
    }
    
    func updateBookMark() -> UIImage {
        movieDetails.isBookMarked = !movieDetails.isBookMarked
        return getBookMarkStatus()
    }
    
    func createSection() {
        self.sections = MovieDetailsSection.allCases.map { $0 }
    }
    
    func getSections() -> [MovieDetailsSection] {
        return sections
    }
    
    func getMovieDetails() -> MFMovie? {
        return movieDetails
    }
    
}
