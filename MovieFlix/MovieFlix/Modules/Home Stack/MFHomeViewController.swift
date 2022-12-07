//
//  MFHomeViewController.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import UIKit

class MFHomeViewController: UIViewController,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout,
                            UITableViewDelegate,
                            UITableViewDataSource,
                            MFHomeViewModelDelegate,
                            StaffPickCellDelegate {

    /// Outlets
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var favoritesLabel: UILabel!
    @IBOutlet private weak var favoritesCollection: UICollectionView!
    @IBOutlet private weak var staffPickList: UITableView!
    @IBOutlet private weak var staffPickListHeight: NSLayoutConstraint!
    
    private var viewModel = MFHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.staffPickList.reloadData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.refreshList),
                                               name: Notification.Name("refreshList"),
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let contentheight = staffPickList.contentSize.height
        self.staffPickListHeight.constant = contentheight
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(Notification.Name("refreshList"))
    }
    
    //MARK: - UI Helpers
    private func setUpView() {
        
        

        let attributedText = NSMutableAttributedString(string: "YOUR",
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: " FAVORITES",
                                                 attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                                                              NSAttributedString.Key.foregroundColor: UIColor.black]))
        favoritesLabel.attributedText = attributedText
        
        viewModel.delegate = self
        viewModel.getJsonData()
        createShape()
        searchView.dropShadow()
        favoritesCollection.dropShadow()
        setUpCells()
    }
    
    private func setUpCells() {
        favoritesCollection.registerCellFromNib(cellIdentifier: FavoriteCell.reuseIdentifier)
        staffPickList.registerCellFromNib(cellIdentifier: StaffPickCell.reuseIdentifier)
        staffPickList.rowHeight = UITableView.automaticDimension
        staffPickList.estimatedRowHeight = 100
    
    }
    
    func createShape() {
        
        let pathForOuterShape = UIBezierPath()
                
        let x: CGFloat = UIScreen.main.bounds.size.width
        let height: CGFloat = self.view.frame.height
        
        pathForOuterShape.move(to: CGPoint(x: 0,
                              y: height * 0.4))
        
        pathForOuterShape.addCurve(to: CGPoint(x: x,
                                               y: height * 0.3),
                                               controlPoint1: CGPoint(x: x * 0.075,
                                                                      y: (height * 0.35) + 0),
                                               controlPoint2: CGPoint(x: x,
                                                                      y: (height * 0.3) + 0))
        
        pathForOuterShape.addLine(to: CGPoint(x: x,
                                 y: 0))
        
        pathForOuterShape.addLine(to: CGPoint(x: 0,
                                 y: 0))
        
        let outerShapeLayer = CAShapeLayer()
        outerShapeLayer.path = pathForOuterShape.cgPath
        outerShapeLayer.fillColor = UIColor.white.cgColor

        self.contentView.layer.insertSublayer(outerShapeLayer, at: 0)
        
    }

    //MARK: - IBActions
    @IBAction func searchAction(_ sender: Any) {
        viewModel.navigateToSearch()
    }
    
    @objc func refreshList() {
        DispatchQueue.main.async { [weak self] in
            self?.staffPickList.reloadData()
        }
    }
    
    //MARK: - Collectionview Delegates & Datasource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // Here the + 1 is for "See all"
        return viewModel.getMoviesData().count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteCell: FavoriteCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if viewModel.getMoviesData().indices.contains(indexPath.row) {
            let dataModel = viewModel.getMoviesData()[indexPath.row]
            favoriteCell.configureCell(movieModel: dataModel)
        } else {
            favoriteCell.configureSeeAllCell()
        }
        
        return favoriteCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (favoritesCollection.frame.width / 1.75),
                      height: favoritesCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.getMoviesData().indices.contains(indexPath.row) {
            viewModel.navigateToMovieDetail(type: .favorites, for: indexPath.row)
        } else {
            // See all clicked
            viewModel.navigateToSearch()
        }
        
    }
    //MARK: - Tableview Delegates & Datasources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.getStaffPickData().count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let staffPickCell: StaffPickCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
        staffPickCell.delegate = self
        let viewModel = StaffPickViewModel(cellData: viewModel.getStaffPickData()[indexPath.row])
        staffPickCell.configureCell(viewModel: viewModel)
        return staffPickCell
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: staffPickList.frame.width,
                                              height: 30))
        let headerLabel = UILabel(frame: headerView.frame)
        
        let attributedText = NSMutableAttributedString(string: "OUR",
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: " STAFF PICKS",
                                                 attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                                                              NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        headerLabel.attributedText = attributedText
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToMovieDetail(type: .staffPicks, for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func updateBookMarkStatus() {
        self.staffPickList.reloadData()
    }
    
    //MARK: - ViewModel Delegates
    func updateMoviesData() {
        DispatchQueue.main.async { [weak self] in
            self?.favoritesCollection.reloadData()
            self?.staffPickList.reloadData()
        }
    }
}

