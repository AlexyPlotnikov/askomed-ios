//
//  PersonInfoViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import Foundation

protocol PersonInfoNavigation : AnyObject{
    func back()
    func hideNavBar()
}


class PersonInfoViewModel{
    weak var navigation: PersonInfoNavigation!
    
    var documentID:Int!
    var fullName:String!
    var personCells = [PersonCellModel(title: "", desc: "ФИО", icon:"user-circle" ,key:"fullName"),
                        PersonCellModel(title: "", desc: "Дата рождения", icon:"calendar" ,key:"dateBirth"),
                        PersonCellModel(title: "", desc: "Телефон", icon:"callIcon" ,key:"phone"),
                       PersonCellModel(title: "", desc: "Страховая компания", icon:"shieldIcon" ,key:"insuranceCompany"),
     PersonCellModel(title: "", desc: "Страховая программа", icon:"spIcon" ,key:"insuranceProgram"),
     PersonCellModel(title: "", desc: "Дата начала", icon:"dateIcon" ,key:"dateStart"),
     PersonCellModel(title: "", desc: "Дата окончания", icon:"dateIcon" ,key:"dateEnd"),
     PersonCellModel(title: "", desc: "Статус", icon:"statusIcon" ,key:"status"),
     PersonCellModel(title: "", desc: "Номер полиса", icon:"policeNumberIcon" ,key:"numberPolicy"),
     PersonCellModel(title: "", desc: "Регион продажи", icon:"mapIcon" ,key:"regionSale"),
     PersonCellModel(title: "", desc: "Регион страховой компании", icon:"mapIcon" ,key:"regionInsuranceCompany"),
     PersonCellModel(title: "", desc: "Страхователь", icon:"mapIcon" ,key:"policyholder")]
  
    init(navigationController : PersonInfoNavigation, documentID:Int, fullName:String) {
            self.navigation = navigationController
            self.documentID = documentID
            self.fullName = fullName
        }
    
    func mapDataByKey(details:PersonInfoDetail){
        if let row = self.personCells.firstIndex(where: {$0.key == "fullName"}) {
            personCells[row].title = self.fullName
        }

        let mirror = Mirror(reflecting: details)
        for item in mirror.children{
            if let row = self.personCells.firstIndex(where: {$0.key == item.label ?? ""}) {
                if(item.label == "dateStart" || item.label == "dateEnd"){
                    personCells[row].title = self.dateFromJSON(item.value as? String ?? "-")
                }else{
                    personCells[row].title = item.value as? String ?? "-"
                }
               
                
            }
           
            
        }
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
