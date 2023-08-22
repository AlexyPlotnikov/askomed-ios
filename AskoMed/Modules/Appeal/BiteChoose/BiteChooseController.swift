//
//  BiteChooseController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 17.07.2023.
//

import UIKit

class BiteChooseController: UIViewController,Storyboardable {

    var viewModel:BiteChooseViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
   

    func dateFromJSON(_ JSONdate: String) -> String {
        if(JSONdate != ""){
            let dateFormatterGet = DateFormatter()
            var tempDate = JSONdate
            if let dotRange = tempDate.range(of: "T") {
                tempDate.removeSubrange(dotRange.lowerBound..<tempDate.endIndex)
            }
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
            if(dateFormatterGet.date(from: tempDate) == nil){
                dateFormatterGet.dateFormat = "dd.MM.yyyy"
            }
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

extension BiteChooseController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.bites.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "biteCell", for: indexPath) as! BiteCell
        if(indexPath.row < self.viewModel.bites.count){
            cell.titleLbl.text = self.dateFromJSON(self.viewModel.bites[indexPath.row].dateBite ?? "")
        }else{
            cell.titleLbl.text = "Добавить страховой случай"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row < self.viewModel.bites.count){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "chooseBite"), object: self.viewModel.bites[indexPath.row], userInfo: nil)
        }else{
            self.viewModel.navigation.createNewBite()
        }
        self.dismiss(animated: true)
    }
    
}
