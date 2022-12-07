//
//  MFSearchViewController.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class MFSearchViewController: MFDefaultViewController,
                              UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout,
                              UITableViewDelegate,
                              UITableViewDataSource,
                              StaffPickCellDelegate {

    var viewModel: MFSearchViewModel?
    
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var ratingsCollectionView: UICollectionView!
    @IBOutlet private weak var movieList: UITableView!
    @IBOutlet private weak var noDataView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.refreshList),
                                               name: Notification.Name("refreshList"),
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(Notification.Name("refreshList"))
    }
    
    private func setUpView() {
        
        searchView.dropShadow()
        searchTextField.inputAccessoryView = self.toolBar
        searchTextField.addTarget(self, action: #selector(self.textEditBegin), for: .editingChanged)
        setUpCells()
    }

    private func setUpCells() {
        movieList.registerCellFromNib(cellIdentifier: StaffPickCell.reuseIdentifier)
        movieList.rowHeight = UITableView.automaticDimension
        movieList.estimatedRowHeight = 100
        ratingsCollectionView.registerCellFromNib(cellIdentifier: RatingsCell.reuseIdentifier)
    }
    
    private func refreshTableView() {
        noDataView.isHidden = (viewModel?.getStaffPickData().count ?? 0) > 0
        self.movieList.reloadData()
        
    }
    
    //MARK: - IBActions and @objc selectors
    @objc
    private func textEditBegin() {
        viewModel?.initiateSearch(searchTerm: searchTextField.text ?? "")
        refreshTableView()
    }
    
    @objc func refreshList() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshTableView()
        }
    }
    
    @IBAction func dismissScreen(_ sender: Any) {
        viewModel?.dismissScreen()
    }
    
    //MARK: - Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ratingsCell: RatingsCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let selectedIndex = viewModel?.getSelectedRatingsIndex() ?? -1
        ratingsCell.configureCell(index: indexPath.row, isSelected: selectedIndex == indexPath.row)
        return ratingsCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((5 - indexPath.row) * 12) + ((4 - indexPath.row) * 5) + 30
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.initiateFilter(index: indexPath.row)
        ratingsCollectionView.reloadData()
        refreshTableView()
    }
    
    //MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getStaffPickData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let staffPickCell: StaffPickCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
        staffPickCell.delegate = self
        let viewModel = StaffPickViewModel(cellData: (viewModel?.getStaffPickData() ?? [])[indexPath.row])
        staffPickCell.configureCell(viewModel: viewModel)
        return staffPickCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToMovieDetail(for: indexPath.row)
    }
    
    func updateBookMarkStatus() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshTableView()
        }
    }
}
