//
//  MFMoviesModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import Foundation

// MARK: - MFMovie
class MFMovie: Codable {
    let rating: Double
    let id: Int
    let revenue: Int?
    let releaseDate: String
    let director: MFMovieCast
    let posterURL: String
    let cast: [MFMovieCast]
    let runtime: Int
    let title, overview: String
    let reviews, budget: Int
    let language: String
    let genres: [String]
    var isBookMarked: Bool = false

    enum CodingKeys: String, CodingKey {
        case rating, id, revenue, releaseDate, director
        case posterURL = "posterUrl"
        case cast, runtime, title, overview, reviews, budget, language, genres
    }
}

// MARK: - Cast
class MFMovieCast: Codable {
    let name: String
    let pictureURL: String
    let character: String?

    enum CodingKeys: String, CodingKey {
        case name
        case pictureURL = "pictureUrl"
        case character
    }
}

//MARK: - Key Factor data set
struct MFKeyFactors {
    let keyFactorName: String
    let keyFactorValue: String
    
    init(keyFactorName: String, keyFactorValue: String) {
        self.keyFactorName = keyFactorName
        self.keyFactorValue = keyFactorValue
    }
}
