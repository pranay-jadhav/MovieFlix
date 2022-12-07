//
//  MFMovieDetailsViewController.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class MFMovieDetailsViewController: UIViewController,
                                    UITableViewDelegate,
                                    UITableViewDataSource {

    @IBOutlet private weak var bookMarkImageView: UIImageView!
    @IBOutlet private weak var movieDetailTableView: UITableView!
    
    var viewModel: MFMovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        viewModel?.createSection()
        setUpCells()
    }
    
    private func setUpCells() {
        bookMarkImageView.image = viewModel?.getBookMarkStatus()
        movieDetailTableView.registerCellFromNib(cellIdentifier: MovieTitleCell.reuseIdentifier)
        movieDetailTableView.registerCellFromNib(cellIdentifier: MovieDescriptionCell.reuseIdentifier)
        movieDetailTableView.registerCellFromNib(cellIdentifier: UserProfileCell.reuseIdentifier)
        
        movieDetailTableView.rowHeight = UITableView.automaticDimension
        movieDetailTableView.estimatedRowHeight = 100
        
    }
    
    //MARK: - IBActions
    @IBAction func saveBookMarkAction(_ sender: Any) {
        bookMarkImageView.image = viewModel?.updateBookMark()
    }
    
    @IBAction func dismissScreen(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshList"), object: nil, userInfo: nil)
        self.dismiss(animated: true)
    }
    
    //MARK: - Tableview Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getSections().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel?.getSections()[indexPath.section] {
        case .header:
            let movieTitleCell: MovieTitleCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
            if let movieDetails = viewModel?.getMovieDetails() {
                let dataModel = MovieTitleModel(dataModel: movieDetails)
                movieTitleCell.configureCell(viewModel: dataModel)
            }
            return movieTitleCell
        case .overview:
            let movieDescriptionCell: MovieDescriptionCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
            if let movieDetails = viewModel?.getMovieDetails() {
                movieDescriptionCell.configureCell(description: movieDetails.overview)
            }
            return movieDescriptionCell
            
        case .directorSection:
            let userProfileCell: UserProfileCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
            if let movieDetails = viewModel?.getMovieDetails() {
                let viewModel = UserProfileModel(dataModel: movieDetails)
                userProfileCell.configureHorizontalCell(collectionViewType: .directorSection,
                                                        viewModel: viewModel)
            }
            
            return userProfileCell
            
        case .actorSection:
            let userProfileCell: UserProfileCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
            if let movieDetails = viewModel?.getMovieDetails() {
                let viewModel = UserProfileModel(dataModel: movieDetails)
                userProfileCell.configureHorizontalCell(collectionViewType: .actorSection,
                                                        viewModel: viewModel)
            }
            return userProfileCell
            
        case .keyFactsSection:
            let userProfileCell: UserProfileCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
            if let movieDetails = viewModel?.getMovieDetails() {
                let viewModel = UserProfileModel(dataModel: movieDetails)
                userProfileCell.configureVerticalCell(collectionViewType: .keyFactsSection,
                                                      viewModel: viewModel)
            }
            
            return userProfileCell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 30,
                                              y: 0,
                                              width: self.movieDetailTableView.frame.width,
                                              height: 30))
        let headerLabel = UILabel(frame: headerView.frame)
        headerLabel.text = viewModel?.getSections()[section].rawValue
        headerLabel.font = .boldSystemFont(ofSize: 17)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel?.getSections()[indexPath.section] {
        case .directorSection, .actorSection:
            return 200
        case .keyFactsSection:
            return 230
        default:
            return UITableView.automaticDimension
        }
    }

}
