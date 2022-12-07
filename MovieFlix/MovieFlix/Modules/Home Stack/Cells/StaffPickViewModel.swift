//
//  StaffPickViewModel.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import Foundation

//MARK: - View model for staff pick cell
class StaffPickViewModel {
    
    private var cellData: MFMovie
    
    init(cellData: MFMovie) {
        self.cellData = cellData
    }
    
    /// Return cell data
    func getDataModel() -> MFMovie {
        return cellData
    }
    
    /// Update bookmark status
    func updateBookMarkStatus() {
        cellData.isBookMarked = !cellData.isBookMarked
    }
}
