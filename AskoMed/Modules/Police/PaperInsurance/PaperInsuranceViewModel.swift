//
//  PaperInsuranceViewModel.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import Foundation


protocol PaperInsurancNavigation : AnyObject{
    func chooseInsuranse()
    func hideNavBar()
}

class PaperInsuranceViewModel{
    
    weak var navigation : PaperInsurancNavigation!
    var paramSend = SearchParam(immunocard: false,fullName:"",dateBirth: "",series: "",number: "")
    
    init(navigationController : PaperInsurancNavigation) {
            self.navigation = navigationController
        }
    
   
}
