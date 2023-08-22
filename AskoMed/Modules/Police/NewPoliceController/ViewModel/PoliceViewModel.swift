//
//  PoliceViewModel.swift
//  AskoMed
//
//  Created by RX Group on 30.03.2023.
//

import Foundation

protocol NewPoliceNavigation : AnyObject{
    func hideNavBar()
    func openInsurance()
}

class NewPoliceViewModel{
    
    weak var navigation : NewPoliceNavigation!
    
    init(navigationController : NewPoliceNavigation) {
            self.navigation = navigationController
        }
    
   
}

