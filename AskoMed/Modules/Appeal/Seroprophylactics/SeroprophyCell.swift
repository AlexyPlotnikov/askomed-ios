//
//  SeroprophyCell.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import UIKit

class SeroprophyCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topField: RoundedField!
    @IBOutlet weak var bottomField: RoundedField!
    @IBOutlet weak var commentField: RoundedField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
