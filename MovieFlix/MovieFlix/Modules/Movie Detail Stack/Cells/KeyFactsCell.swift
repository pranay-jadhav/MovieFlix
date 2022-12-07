//
//  KeyFactsCell.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 06/12/22.
//

import UIKit

class KeyFactsCell: UICollectionViewCell {
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    /// Configure keyfactor cell
    func configureCell(keyFactors: MFKeyFactors) {
        headerLabel.text = keyFactors.keyFactorName
        valueLabel.text = keyFactors.keyFactorValue
    }
}
