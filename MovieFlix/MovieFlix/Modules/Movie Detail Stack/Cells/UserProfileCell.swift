//
//  UserProfileCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class UserProfileCell: UITableViewCell,
                       UICollectionViewDelegate,
                       UICollectionViewDataSource,
                       UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var profileCollection: UICollectionView!
    var collectionViewType: MovieDetailsSection?
    var viewModel: UserProfileModel?
    
    /// Configure cell for Directors / Cast
    func configureHorizontalCell(collectionViewType: MovieDetailsSection,
                                 viewModel: UserProfileModel) {
        selectionStyle = .none
        self.viewModel = viewModel
        profileCollection.dropShadow(opacity: 0.2)
        self.collectionViewType = collectionViewType
        setUpCollectionView()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 20
        profileCollection.collectionViewLayout = collectionViewLayout
    }
    
    /// Configure cell for Key factors
    func configureVerticalCell(collectionViewType: MovieDetailsSection,
                               viewModel: UserProfileModel) {
        selectionStyle = .none
        self.viewModel = viewModel
        self.collectionViewType = collectionViewType
        setUpCollectionView()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 5
        profileCollection.collectionViewLayout = collectionViewLayout
    }
    
    private func setUpCollectionView() {
        profileCollection.delegate = self
        profileCollection.dataSource = self
        profileCollection.registerCellFromNib(cellIdentifier: FavoriteCell.reuseIdentifier)
        profileCollection.registerCellFromNib(cellIdentifier: KeyFactsCell.reuseIdentifier)
    }
    
    //MARK: - Collection view delegates & datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.collectionViewType == .keyFactsSection {
            return 4
            
        } else if self.collectionViewType == .directorSection {
            return 1
            
        } else {
            return (viewModel?.dataModel.cast.count ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.collectionViewType == .keyFactsSection {
            let keyFactsCell: KeyFactsCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let keyFactor = viewModel?.keyFactors[indexPath.row] {
                keyFactsCell.configureCell(keyFactors: keyFactor)
            }
            return keyFactsCell
            
        } else if self.collectionViewType == .directorSection {
            let favoriteCell: FavoriteCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let dataModel = viewModel?.dataModel {
                favoriteCell.configureCellForDirector(dataModel: dataModel)
            }
            return favoriteCell
        } else {
            let favoriteCell: FavoriteCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let dataModel = viewModel?.dataModel.cast[indexPath.row] {
                favoriteCell.configureCellForCast(cast: dataModel)
            }
            return favoriteCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.collectionViewType == .keyFactsSection {
            return CGSize(width: (self.profileCollection.frame.width / 2) - 5,
                          height:(self.profileCollection.frame.height / 2) - 20)
            
        } else {
            return CGSize(width: (self.profileCollection.frame.width / 2.75) - 5,
                          height: self.profileCollection.frame.height)
        }
    }
}
