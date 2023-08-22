//
//  InsuranceProgramViewModel.swift
//  AskoMed
//
//  Created by RX Group on 31.03.2023.
//

import Foundation

protocol InsuranceProgramNavigation : AnyObject{
    func closeInsuranse()
}

class InsuranceProgramViewModel{
    
    weak var navigation : InsuranceProgramNavigation!
    var insuranceProgram:[String] = []
    
    init(navigationController : InsuranceProgramNavigation) {
            self.navigation = navigationController
        }
    
   
}
