//
//  PersonDetailController.swift
//  AskoMed
//
//  Created by RX Group on 27.03.2023.
//

import UIKit
import Alamofire

class PersonDetailController: UIViewController, Storyboardable {
    
    var viewModel:PersonDetailViewModel!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateAppeal()
        
        table.estimatedRowHeight = 60
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updadeBite(notification:)), name: NSNotification.Name("updateBite"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAppeal), name: NSNotification.Name("updateAppeal"), object: nil)
    }
    
    @objc func updateAppeal(){
        let headers: HTTPHeaders = [
            "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
            "Authorization": "Bearer \(authToken ?? "")"]
        let params = AppealSend(documentId: self.viewModel.model.documentId ?? 0, biteId: 0)
        AF.request(
            domain + "/mobileapp/appeals", method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: Appeal.self, completionHandler: {
            result in
                       self.viewModel.appeal = result.value
                       if((result.value?.bites?.count ?? 0) > 0){
                           self.viewModel.currentBitteID = (result.value!.bites![0].biteId)!
                       }
                       self.table.reloadData()
                       
          
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.table.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.viewModel.navigation.hideNavBar()
        }
    }
    
    @IBAction func addAppeal(_ sender: Any) {
        self.viewModel.navigation.newAppeal(documentID: self.viewModel.model.documentId ?? 0, bites: self.viewModel.appeal?.bites ?? [])
    }
    
    func dateFromJSON(_ JSONdate: String) -> String {
        if(JSONdate != ""){
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            if(dateFormatterGet.date(from: JSONdate) == nil){
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            }
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
            dateFormatterPrint.dateStyle = DateFormatter.Style.medium
            dateFormatterPrint.locale = NSLocale(localeIdentifier: "ru") as Locale
            
            let date = dateFormatterGet.date(from: JSONdate)
            
            return dateFormatterPrint.string(from: date!)
        }else{
            return ""
        }
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    @objc func updadeBite(notification: NSNotification){
        self.viewModel.currentBitteID = notification.object as! Int
        self.table.reloadData()
        
    }
}


extension PersonDetailController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 2
        }else{
            return 1 + self.viewModel.getAppealByBite(biteID: self.viewModel.currentBitteID).count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }else{
            return 26
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){
            return nil
        }else{
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 26))
                    
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width-32, height: headerView.frame.height)
            label.text = "Обращения"
            label.font = UIFont(name: "Inter-ExtraBold", size: 20)!
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = self.viewModel.model!
        if (indexPath.section == 0){
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "personInfoCell", for: indexPath) as! PersonDetailCell
                
                cell.fullNameLbl.text = person.fullName
               
                cell.documentNumberLbl.text = "\(self.dateFromJSON(person.dateBirth ?? "")) · \(person.numberPolicy ?? "")"
                cell.statusCollectionView.delegate = self
                cell.statusCollectionView.dataSource = self
                cell.statusCollectionView.tag = indexPath.row
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "conditionsCell", for: indexPath) as! PersonDetailCell
                
                return cell
            }
        }else{
            if(indexPath.row == 0){
                if((self.viewModel.appeal?.bites?.count ?? 0) > 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "appealDateCell", for: indexPath) as! PersonDetailCell
                    if(self.viewModel.currentBitteID == 0){
                        cell.appealLbl.text = "Все страховые случаи"
                    }else{
                        cell.appealLbl.text = "Страховой случай " +  self.dateFromJSON((self.viewModel.appeal?.bites?.first(where: {$0.biteId == self.viewModel.currentBitteID})?.dateBite) ?? "")
                    }
                   
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "noFoundCell", for: indexPath) as! PersonDetailCell
                    return cell
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "appealCell", for: indexPath) as! PersonDetailCell
                let appeal = self.viewModel.getAppealByBite(biteID: self.viewModel.currentBitteID)[indexPath.row - 1]
                cell.organizationNameLbl.text = appeal.hospitalTitle
                cell.organizationAdresLbl.text = appeal.hospitalAddress
                cell.createLbl.text = "Создан страховой случай: " + self.dateFromJSON(appeal.dateCreate ?? "")
                cell.applicationLbl.text = "Обращение: " + self.dateFromJSON(appeal.dateApplication ?? "")
                cell.biteLbl.text = "Укус: " + self.dateFromJSON(appeal.dateBite ?? "")
    
                cell.createServicesView(services: appeal.services ?? [])
              
                return cell
            }
           
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                self.viewModel.navigation.showPersonInfo(documentID: self.viewModel.model.documentId ?? 0, fullName: self.viewModel.model.fullName ?? "")
            }else{
                self.viewModel.navigation.showServiceInfo(documentID: self.viewModel.model.documentId ?? 0)
            }
        }else{
            if(self.viewModel.getAppealByBite(biteID: self.viewModel.currentBitteID).count != 0){
                if(indexPath.row == 0){
                    self.viewModel.navigation.showBites(bites: (self.viewModel.appeal?.bites!)!)
                }else{
                    self.viewModel.navigation.showHistoryService(appeal: self.viewModel.getAppealByBite(biteID: self.viewModel.currentBitteID)[indexPath.row - 1])
                }
            }
        }
    }
    
    
}

extension PersonDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statusCell", for: indexPath) as! StatusCell
        
        let history = viewModel.model.tags[indexPath.row]
        
        cell.statusLbl.text = history.title
        cell.statusLbl.backgroundColor = self.hexStringToUIColor(hex: history.backGroundColor ?? "")
        cell.statusLbl.textColor =  self.hexStringToUIColor(hex: history.textColor ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let history = viewModel.model.tags[indexPath.row]
        let width = (history.title?.widthOfString(usingFont: UIFont(name: "Inter-Medium", size: 13)!) ?? 0) + 20
      
        return CGSize(width: width, height: 24)
    }
    
    
}
