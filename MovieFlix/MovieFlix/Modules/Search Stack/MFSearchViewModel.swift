//
//  MFSearchViewModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import Foundation

class MFSearchViewModel {
    
    private var staffPick = [MFMovie]()
    private var copyOfStaffPick = [MFMovie]()
    private var selectedIndex = -1
    
    init (staffPick: [MFMovie]) {
        self.staffPick = staffPick
        self.copyOfStaffPick = staffPick
    }
    
    //MARK: - Data helpers
    func getStaffPickData() -> [MFMovie] {
        return staffPick
    }
    
    func getSelectedRatingsIndex() -> Int {
        return selectedIndex
    }
    
    //MARK: - Search & Filter helpers
    func initiateSearch(searchTerm: String){
        if searchTerm == "" {
            staffPick = copyOfStaffPick
        } else {
            staffPick = copyOfStaffPick.filter { picks in
                picks.title.contains(searchTerm) || picks.releaseDate.contains(searchTerm)
            }
        }
    }
    
    func initiateFilter(index: Int){
        selectedIndex = index
        let rating = 5 - index
        staffPick = copyOfStaffPick.filter { picks in
            Int(picks.rating.rounded()) == rating
        }
    }
    
    //MARK: - Navigation helpers
    func dismissScreen() {
        NavigationHelper.shared.dismissScreen()
    }
    
    func navigateToMovieDetail(for index: Int) {
        let movieDetails = staffPick[index]
        NavigationHelper.shared.navigateToMovieDetails(movieDetails: movieDetails)
    }
}
