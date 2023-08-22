//
//  ServiceHistoryCell.swift
//  AskoMed
//
//  Created by Алексей Плотников on 16.07.2023.
//

import UIKit

class ServiceHistoryCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var corcleView: UIView!
    
    @IBOutlet weak var topTitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
