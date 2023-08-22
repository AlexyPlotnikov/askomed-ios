//
//  AppealServicesController.swift
//  AskoMed
//
//  Created by RX Group on 04.04.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class AppealServicesController: UIViewController, Storyboardable {

    var viewModel:AppealServiceViewModel!
    @IBOutlet weak var table: UITableView!
    var disposeBag:DisposeBag = DisposeBag()
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(addTapped))
        table.estimatedRowHeight = 148
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }
    

    @objc func addTapped(){
        self.viewModel.navigation.back()
    }

    @IBAction func nextTapped(_ sender: Any) {
        let seroprohy = self.viewModel.services.services?.filter({$0.seroprofilactic == true})
        if(self.viewModel.items.contains(seroprohy?[0].linkPriceServicesId ?? 0)){
            self.viewModel.navigation.seroprophylactics(sendModel: AppealServiceSend(dateBite: self.dateFromJSON(self.viewModel.dates.1), dateAppeal: self.viewModel.dates.0, immunocardId: self.viewModel.documentID, items: self.viewModel.items))
        }else{
            let headers: HTTPHeaders = [
                "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
                "Authorization": "Bearer \(authToken ?? "")"]
            
            let params = AppealServiceSend(dateBite: self.dateFromJSON(self.viewModel.dates.1), dateAppeal: self.viewModel.dates.0, immunocardId: self.viewModel.documentID, items: self.viewModel.items)
            
            AF.request(
                domain + "/mobileapp/createinsurancecase", method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).responseDecodable(of: AppealServiceGet.self, completionHandler: {
                result in
                           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAppeal"), object: nil, userInfo: nil)
                           self.viewModel.navigation.chooseServices()
            })
        }
        
            
    }
    
    @objc func switcherChange(switcher:UISwitch){
        if(self.viewModel.items.contains(switcher.tag)){
            if let index = self.viewModel.items.firstIndex(where: {$0 == switcher.tag}){
                self.viewModel.items.remove(at: index)
            }
        }else{
            self.viewModel.items.append(switcher.tag)
        }
        self.table.reloadData()
        nextBtn.isEnabled = self.viewModel.items.count > 0
    }
    
    func dateFromJSON(_ JSONdate: String) -> String {
        if(JSONdate != ""){
            let dateFormatterGet = DateFormatter()
            var tempDate = JSONdate
            if let dotRange = tempDate.range(of: "T") {
                tempDate.removeSubrange(dotRange.lowerBound..<tempDate.endIndex)
            }
                dateFormatterGet.dateFormat = "d MMM yyyy"
            dateFormatterGet.dateStyle = DateFormatter.Style.medium
            dateFormatterGet.locale = NSLocale(localeIdentifier: "ru") as Locale
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd.MM.yyyy"
            
            let date = dateFormatterGet.date(from: tempDate)
            
            return dateFormatterPrint.string(from: date!)
        }else{
            return ""
        }
    }
}

extension AppealServicesController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.services.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.viewModel.getServicesBySection(section: section).count) + 1 + (self.viewModel.isSeroprophylactics(section: section) ? 1:0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleServiceCell", for: indexPath) as! AppealServiceCell
            cell.sectionLbl.text = self.viewModel.services.sections![indexPath.section].title ?? ""
            
            return cell
        }else{
            
            if(self.viewModel.isSeroprophylactics(section: indexPath.section) && indexPath.row == 2){
                let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AppealServiceCell
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath) as! AppealServiceCell
                let names = self.viewModel.getServicesBySection(section: indexPath.section)[indexPath.row-1].servicesSystem!
                var createdName = ""
                for name in names{
                    createdName = createdName + name + " "
                }
                cell.serviceTitleLbl.text = createdName
                cell.serviceDescLbl.text = self.viewModel.getServicesBySection(section: indexPath.section)[indexPath.row-1].servicesPrice![0]
                cell.switcher.tag = self.viewModel.getServicesBySection(section: indexPath.section)[indexPath.row-1].linkPriceServicesId!
                cell.switcher.addTarget(self, action: #selector(switcherChange(switcher: )), for: .valueChanged)
                cell.switcher.isOn = self.viewModel.items.contains(self.viewModel.getServicesBySection(section: indexPath.section)[indexPath.row-1].linkPriceServicesId!)
                
                return cell
            }
            
        }
            
    }
    
    
}
