//
//  UserProfileViewModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import Foundation

//MARK: - User profile model
struct UserProfileModel {
    
    var dataModel: MFMovie
    var keyFactors = [MFKeyFactors]()
    
    init(dataModel: MFMovie) {
        self.dataModel = dataModel
        
        self.keyFactors.append(MFKeyFactors(keyFactorName: "Budget",
                                            keyFactorValue: "$ \(dataModel.budget)"))
        self.keyFactors.append(MFKeyFactors(keyFactorName: "Revenue",
                                            keyFactorValue: "$ \(dataModel.revenue ?? 0)"))
        self.keyFactors.append(MFKeyFactors(keyFactorName: "Original Language",
                                            keyFactorValue: "\(dataModel.language)"))
        self.keyFactors.append(MFKeyFactors(keyFactorName: "Rating",
                                            keyFactorValue: "\(String(format: "%.2f", dataModel.rating)) (\(dataModel.reviews))"))
    }
}
