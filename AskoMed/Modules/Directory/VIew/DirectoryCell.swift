//
//  DirectoryCell.swift
//  AskoMed
//
//  Created by RX Group on 17.04.2023.
//

import UIKit

class DirectoryCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var searchField: RoundedField!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = 13
        backView.layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.1).cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowRadius = 8
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    
    func setupView(){
        segmentControll.defaultConfiguration()
        segmentControll.selectedConfiguration()
        
    }
}
