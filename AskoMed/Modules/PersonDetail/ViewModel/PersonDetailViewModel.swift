//
//  PersonDetailViewModel.swift
//  AskoMed
//
//  Created by RX Group on 27.03.2023.
//

import Foundation

protocol PersonDetailNavigation : AnyObject{
    func back()
    func hideNavBar()
    func newAppeal(documentID:Int, bites:[Bite])
    func showPersonInfo(documentID:Int, fullName:String)
    func showServiceInfo(documentID:Int)
    func showBites(bites:[Bite])
    func showHistoryService(appeal:AppealItem)
}


class PersonDetailViewModel{
    weak var navigation: PersonDetailNavigation!
    var model:Insured!
    var appeal:Appeal?
    var currentBitteID:Int = 0
    
    init(navigationController : PersonDetailNavigation) {
            self.navigation = navigationController
       
        }
    
    func getAppealByBite(biteID:Int)->[AppealItem]{
        if(biteID == 0){
            return self.appeal?.items ?? []
        }else{
            return self.appeal?.items?.filter({$0.biteId == biteID}) ?? []
        }
       
    }
}
