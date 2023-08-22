//
//  PaperInfoCell.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import UIKit

class PaperInfoCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if(reuseIdentifier == "infoCell"){
            backView.layer.cornerRadius = 13
            backView.layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.1).cgColor
            backView.layer.shadowOpacity = 1
            backView.layer.shadowRadius = 8
            backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        }else{
            backView.layer.cornerRadius = 12
            backView.layer.borderColor = UIColor.init(displayP3Red: 186/255, green: 195/255, blue: 241/255, alpha: 1).cgColor
            backView.layer.borderWidth = 1
        }
    }

}
