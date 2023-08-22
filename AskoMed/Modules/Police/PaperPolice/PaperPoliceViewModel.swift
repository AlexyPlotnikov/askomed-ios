//
//  PaperPoliceViewModel.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import Foundation

protocol PaperPoliceNavigation : AnyObject{
    func createPaperPolice()
    func hideNavBar()
    func openCamera()
}

class PaperPoliceViewModel{
    
    weak var navigation : PaperPoliceNavigation!
   
    init(navigationController : PaperPoliceNavigation) {
            self.navigation = navigationController
        }
}
