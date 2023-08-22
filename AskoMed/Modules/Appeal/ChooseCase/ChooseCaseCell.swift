//
//  ChooseCaseCell.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import UIKit

class ChooseCaseCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var topField: RoundedField!
    @IBOutlet weak var bottomField: RoundedField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = 13
        backView.layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.1).cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowRadius = 8
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

}
