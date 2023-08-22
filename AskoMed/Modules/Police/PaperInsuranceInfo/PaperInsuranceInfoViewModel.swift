//
//  PaperInsuranceInfoViewModel.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import Foundation


protocol PaperInsurancInfoNavigation : AnyObject{
    func acceptInsuranse()
}

class PaperInsuranceInfoViewModel{
    
    weak var navigation : PaperInsurancInfoNavigation!
   
    
    init(navigationController : PaperInsurancInfoNavigation) {
            self.navigation = navigationController
        }
    
}
