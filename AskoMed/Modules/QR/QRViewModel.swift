//
//  QRViewModel.swift
//  AskoMed
//
//  Created by RX Group on 30.03.2023.
//

import Foundation


protocol QRNavigation : AnyObject{
   func back()
}

class QRViewModel{
    
    weak var navigation : QRNavigation!
    
    init(navigationController : QRNavigation) {
            self.navigation = navigationController
        }
    
   
}
