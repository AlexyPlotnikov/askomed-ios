//
//  ServiceInfoController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import UIKit
import Alamofire

class ServiceInfoController: UIViewController,Storyboardable {

    var viewModel:ServiceInfoViewModel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var InsuranceCompanyLbl: UILabel!
    @IBOutlet weak var insuranceProgramLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 54
        table.rowHeight = UITableView.automaticDimension
        
        let headers: HTTPHeaders = [
            "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
            "Authorization": "Bearer \(authToken ?? "")"]
        AF.request(
            domain + "/mobileapp/insuranceprogramservices?documentid=\(self.viewModel.documentID ?? 0)", method: .get,
                   headers: headers).responseDecodable(of: ServiceInfoModel.self, completionHandler: {
            result in
                       print(result)
                       self.InsuranceCompanyLbl.text = result.value?.title
                       self.insuranceProgramLbl.text = result.value?.insuranceCompanyTitle
                       self.viewModel.model = result.value
                       self.table.reloadData()
                   
                       
          
        })
       
    }
    

    

}

extension ServiceInfoController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.model?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel.model?.items?[section].items?.count ?? 0) + 1
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleStatusCell", for: indexPath) as! ServiceInfoCell
            cell.topTitleLbl.text = self.viewModel.model?.items?[indexPath.section].title ?? "-"
            
            return cell
        }else{
            let info = self.viewModel.model!.items![indexPath.section].items![indexPath.row-1]
            if(info.type == 1){
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! ServiceInfoCell
                
               
                cell.titleLbl.text = info.information
                cell.descLbl.text = info.title
                cell.icon.image = UIImage(named: "serviceIcon\(info.iconId ?? 1)")
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoStatusCell", for: indexPath) as! ServiceInfoCell
                
               
                cell.topTitleLbl.text = info.title
                cell.statusLbl.text = info.information
                cell.statusWidth.constant = info.information!.widthOfString(usingFont: UIFont(name: "Inter-Medium", size: 12)!) + 20
                cell.statusLbl.textColor = info.information == "Да" ? UIColor(red: 0.05, green: 0.69, blue: 0.54, alpha: 1):UIColor(red: 0.65, green: 0.11, blue: 0.06, alpha: 1)
                cell.statusLbl.backgroundColor = info.information == "Да" ? UIColor(red: 0.76, green: 0.91, blue: 0.85, alpha: 1):UIColor(red: 0.96, green: 0.85, blue: 0.85, alpha: 1)
                cell.statusLbl.layer.cornerRadius = 12
                cell.statusLbl.layer.masksToBounds = true
                cell.icon.image = UIImage(named: "serviceIcon\(info.iconId ?? 1)")
                
                return cell
            }
        }
        
        
    }
    
    
}
