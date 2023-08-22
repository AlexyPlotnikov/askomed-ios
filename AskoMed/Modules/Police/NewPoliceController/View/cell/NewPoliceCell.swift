//
//  NewPoliceCell.swift
//  AskoMed
//
//  Created by RX Group on 31.03.2023.
//

import UIKit

class NewPoliceCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var insuranceField: RoundedField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if(backView != nil){
            backView.layer.cornerRadius = 13
            backView.layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.1).cgColor
            backView.layer.shadowOpacity = 1
            backView.layer.shadowRadius = 8
            backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
       
    }

}
