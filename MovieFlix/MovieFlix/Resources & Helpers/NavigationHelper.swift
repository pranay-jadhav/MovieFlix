//
//  NavigationHelper.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

enum MFStoryBoards: String {
    case main = "Main"
}

enum MFViewControllers: String {
    case home = "MFHomeViewController"
    case search = "MFSearchViewController"
    case movieDetails = "MFMovieDetailsViewController"
}

class NavigationHelper {
    
    static let shared = NavigationHelper()
    
    func dismissScreen() {
        let topMostViewController = UIApplication.shared.topMostViewController()
        topMostViewController?.navigationController?.popViewController(animated: true)
    }
    
    /// Navigate to search screen
    func navigateToSearch(staffPick: [MFMovie]) {
        let mainSB = UIStoryboard(name: MFStoryBoards.main.rawValue,bundle: nil)
        let searchViewController = mainSB.instantiateViewController(withIdentifier: MFViewControllers.search.rawValue) as! MFSearchViewController
        searchViewController.viewModel = MFSearchViewModel(staffPick: staffPick)
        let topMostViewController = UIApplication.shared.topMostViewController()
        topMostViewController?.navigationController?.pushViewController(searchViewController,
                                                                        animated: true)
    }
    
    /// Navigate to Movie details screen
    func navigateToMovieDetails(movieDetails: MFMovie) {
        let mainSB = UIStoryboard(name: MFStoryBoards.main.rawValue,bundle: nil)
        let movieDetailViewController = mainSB.instantiateViewController(withIdentifier: MFViewControllers.movieDetails.rawValue) as! MFMovieDetailsViewController
        movieDetailViewController.isModalInPresentation = true
        movieDetailViewController.viewModel = MFMovieDetailViewModel(movieDetails: movieDetails)
        let topMostViewController = UIApplication.shared.topMostViewController()
        topMostViewController?.navigationController?.present(movieDetailViewController,
                                                             animated: true)
    }
}


