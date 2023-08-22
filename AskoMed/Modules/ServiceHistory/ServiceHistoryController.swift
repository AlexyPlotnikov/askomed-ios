//
//  ServiceHistoryController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 16.07.2023.
//

import UIKit
import SDWebImage

class ServiceHistoryController: UIViewController, Storyboardable {

    var viewModel:ServiceHistoryViewModel!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print(self.viewModel.appeal)
        
    }
    

    func dateFromJSON(_ JSONdate: String) -> String {
        if(JSONdate != ""){
            let dateFormatterGet = DateFormatter()
            var tempDate = JSONdate
            if let dotRange = tempDate.range(of: "T") {
                tempDate.removeSubrange(dotRange.lowerBound..<tempDate.endIndex)
            }
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
            dateFormatterPrint.dateStyle = DateFormatter.Style.medium
            dateFormatterPrint.locale = NSLocale(localeIdentifier: "ru") as Locale
            
            let date = dateFormatterGet.date(from: tempDate)
            
            return dateFormatterPrint.string(from: date!)
        }else{
            return ""
        }
    }

}

extension ServiceHistoryController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.viewModel.appeal.services?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if(section<(self.viewModel.appeal.services?.count ?? 0)){
            if(self.viewModel.appeal.services![section].items?.count == 0){
                if(self.viewModel.appeal.services?[section].countIG != nil && self.viewModel.appeal.services?[section].weight != nil){
                    count = 3
                }else{
                    count = 1
                }
            }else{
                    count = 1 + self.viewModel.appeal.services![section].items!.count
                
            }
        }else{
            count = 4
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section<(self.viewModel.appeal.services?.count ?? 0)){
            let service = self.viewModel.appeal.services![indexPath.section]
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "serviceNameCell", for: indexPath) as! ServiceHistoryCell
                
                cell.icon.sd_setImage(with: URL(string: service.icon!.encodeUrl)!)
                cell.titleLbl.text = service.title!
                
                return cell
            }else{
                if(service.countIG != nil && service.weight != nil){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "seroInfoCell", for: indexPath) as! ServiceHistoryCell
                    if(indexPath.row == 1){
                        cell.descriptionLbl.text = "Вес пациента"
                        cell.topTitleLbl.text = "\(service.weight!) кг"
                    }else{
                        cell.descriptionLbl.text = "Введено иммуноглобулина"
                        cell.topTitleLbl.text = "\(service.countIG!) мг."
                    }
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "serviceParametersCell", for: indexPath) as! ServiceHistoryCell
                    let item = service.items![indexPath.row-1]
                    cell.titleLbl.text = item.title
                    if(!(item.discovery!)){
                        cell.corcleView.backgroundColor = UIColor.init(displayP3Red: 158/255, green: 161/255, blue: 184/255, alpha: 1)
                    }else{
                        cell.corcleView.backgroundColor = (item.discoveryResult!) ? UIColor.init(displayP3Red: 12/255, green: 175/255, blue: 137/255, alpha: 1):UIColor.init(displayP3Red: 240/255, green: 55/255, blue: 39/255, alpha: 1)
                    }
                    
                    return cell
                }
               
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "insuranceInfoCell", for: indexPath) as! ServiceHistoryCell
            let appeal = self.viewModel.appeal
            if(indexPath.row == 0){
                cell.descriptionLbl.text = appeal?.hospitalTitle
                cell.topTitleLbl.text = "Медицинская организация"
            }else if(indexPath.row == 1){
                cell.descriptionLbl.text = self.dateFromJSON((appeal?.dateBite)!)
                cell.topTitleLbl.text = "Дата укуса"
            }else if(indexPath.row == 2){
                cell.descriptionLbl.text = self.dateFromJSON((appeal?.dateApplication)!)
                cell.topTitleLbl.text = "Дата обращения"
            }else if(indexPath.row == 3){
                cell.descriptionLbl.text = self.dateFromJSON((appeal?.dateCreate)!)
                cell.topTitleLbl.text = "Дата создания карточки обращения"
            }
            
            return cell
        }
    }
    
    
}
