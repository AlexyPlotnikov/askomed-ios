//
//  PersonDetailCell.swift
//  AskoMed
//
//  Created by RX Group on 27.03.2023.
//

import UIKit
import SDWebImage

class PersonDetailCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var documentNumberLbl: UILabel!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var appealLbl: UILabel!
    
    @IBOutlet weak var organizationNameLbl: UILabel!
    @IBOutlet weak var organizationAdresLbl: UILabel!
    @IBOutlet weak var servicesStackView: UIStackView!
    @IBOutlet weak var biteLbl: UILabel!
    @IBOutlet weak var applicationLbl: UILabel!
    @IBOutlet weak var createLbl: UILabel!
    
    @IBOutlet weak var stackviewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
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

    func createServicesView(services:[BiteSrvices]){
        servicesStackView.arrangedSubviews.forEach { servicesStackView.removeArrangedSubview($0);$0.removeFromSuperview()}
        
        let filterItems = services.filter({($0.items?.count ?? 0) > 0})
        stackviewHeight.constant = CGFloat(services.count * 32) + CGFloat(filterItems.count * 32)
        
        
        services.forEach {
            if(($0.items?.count ?? 0) > 0){
               createIcon(service: $0)
               createParams(items: $0.items!)
            }else{
                createIcon(service: $0)
            }
            
        }
      
    }
    
    func createIcon(service:BiteSrvices){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.servicesStackView.frame.size.width, height: 24))
        view.backgroundColor = .clear
        
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        icon.sd_setImage(with: URL(string: service.icon!.encodeUrl)!)
        
        let label = UILabel(frame: CGRect(x:icon.frame.origin.x + icon.frame.size.width + 12, y: 0, width: self.servicesStackView.frame.size.width - 36, height: 24))
        label.text = service.title
        label.font = UIFont(name: "Inter-Regular", size: 14)!
        
        view.addSubview(icon)
        view.addSubview(label)
        servicesStackView.addArrangedSubview(view)
    }
    
    func createParams(items:[BiteItem]){
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.servicesStackView.frame.size.width, height: 24))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        items.forEach{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.servicesStackView.frame.size.width, height: 24))
            view.backgroundColor = .clear
            
            let circleView = UIView(frame: CGRect(x: 0, y: 7, width: 10, height: 10))
            circleView.layer.cornerRadius = 5
            if(!($0.discovery!)){
                circleView.backgroundColor = UIColor.init(displayP3Red: 158/255, green: 161/255, blue: 184/255, alpha: 1)
            }else{
                circleView.backgroundColor = ($0.discoveryResult!) ? UIColor.init(displayP3Red: 12/255, green: 175/255, blue: 137/255, alpha: 1):UIColor.init(displayP3Red: 240/255, green: 55/255, blue: 39/255, alpha: 1)
            }
            let label = UILabel(frame: CGRect(x:circleView.frame.origin.x + circleView.frame.size.width + 8, y: 0, width: ($0.title?.widthOfString(usingFont: UIFont(name: "Inter-Regular", size: 14)!))!, height: 24))
            label.text = $0.title
            label.font = UIFont(name: "Inter-Regular", size: 14)!
            view.addSubview(circleView)
            view.addSubview(label)
            stackView.addArrangedSubview(view)
           
        }
        self.servicesStackView.addArrangedSubview(stackView)
    }
    
}
