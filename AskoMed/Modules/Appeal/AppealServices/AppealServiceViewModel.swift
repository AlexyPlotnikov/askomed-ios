//
//  AppealServiceViewModel.swift
//  AskoMed
//
//  Created by RX Group on 04.04.2023.
//

import Foundation

protocol AppealServiceNavigation : AnyObject{
    func chooseServices()
    func seroprophylactics(sendModel:AppealServiceSend)
    func back()
    
}

class AppealServiceViewModel{
    
    weak var navigation : AppealServiceNavigation!
    var services:ServicesAppeal!
    var dates:(String, String)!
    var items:[Int] = []
    var documentID:Int!
    
    init(navigationController : AppealServiceNavigation, services:ServicesAppeal, dates:(String, String), documentID:Int) {
            self.navigation = navigationController
            self.services = services
            self.dates = dates
            self.documentID = documentID
        }
    
    func getServicesBySection(section:Int)->[ServicesSection]{
        return (services.services?.filter({$0.sectionId == (section+1)})) ?? []
    }
    
    func isSeroprophylactics(section:Int)->Bool{
        let seroprohy = self.getServicesBySection(section: section).filter({$0.seroprofilactic == true})
        if seroprohy.count > 0{
            print(self.items, seroprohy[0])
            return self.items.contains(seroprohy[0].linkPriceServicesId!)
        }else{
            return false
        }
        
    }
}
