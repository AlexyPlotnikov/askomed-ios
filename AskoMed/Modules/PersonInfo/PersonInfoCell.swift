//
//  PersonInfoCell.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import UIKit

class PersonInfoCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var widthTitle: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
