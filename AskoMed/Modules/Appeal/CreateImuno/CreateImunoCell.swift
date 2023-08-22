//
//  CreateImunoCell.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import UIKit

class CreateImunoCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textField: RoundedField!
    @IBOutlet weak var createBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
