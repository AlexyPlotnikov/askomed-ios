//
//  ChooseInsuranceViewModel.swift
//  AskoMed
//
//  Created by RX Group on 31.03.2023.
//

import Foundation

protocol ChooseInsuranceNavigation : AnyObject{
    func openInsuranceProgram(programs:[String])
}

class ChooseInsuranceViewModel{
    
    weak var navigation : ChooseInsuranceNavigation!
    
    init(navigationController : ChooseInsuranceNavigation) {
            self.navigation = navigationController
        }
    
   
}
