//
//  MFHomeViewModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import Foundation

//MARK: - Types of sectin on home page
enum MoviesType {
    case favorites
    case staffPicks
}

//MARK: - Protocol to update from viewmodel to controller
protocol MFHomeViewModelDelegate: AnyObject {
    func updateMoviesData()
}

class MFHomeViewModel {
    
    private var moviesData = [MFMovie]()
    private var staffPick = [MFMovie]()
    
    weak var delegate: MFHomeViewModelDelegate?
    
    init() {}
    
    //MARK: - Data Helpers
    func getMoviesData() -> [MFMovie] {
        return moviesData
    }
    
    func getStaffPickData() -> [MFMovie] {
        return staffPick
    }
    
    //MARK: - JSON Helper
    func getJsonData() {
        MFJSONParser.shared.generateJSONData(.movies,
                                             [MFMovie].self) { moviesData in
            self.moviesData = moviesData
            self.delegate?.updateMoviesData()
        }
        MFJSONParser.shared.generateJSONData(.staffPick,
                                             [MFMovie].self) { staffPick in
            self.staffPick = staffPick
            self.delegate?.updateMoviesData()
        }
    }
    
    //MARK: - Navigation Helpers
    func navigateToSearch() {
        NavigationHelper.shared.navigateToSearch(staffPick: self.staffPick)
    }
    
    func navigateToMovieDetail(type: MoviesType,
                               for index: Int) {
        let movieDetails = type == .favorites ? moviesData[index] : staffPick[index]
        NavigationHelper.shared.navigateToMovieDetails(movieDetails: movieDetails)
    }
    
}
