//
//  StatusCell.swift
//  AskoMed
//
//  Created by RX Group on 16.03.2023.
//

import UIKit

class StatusCell: UICollectionViewCell {
    
    @IBOutlet weak var statusLbl: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        statusLbl.layer.cornerRadius = 12
        statusLbl.layer.masksToBounds = true
    }
}
