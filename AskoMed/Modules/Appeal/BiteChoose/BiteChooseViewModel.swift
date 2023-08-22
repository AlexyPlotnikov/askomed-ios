//
//  BiteChooseViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 17.07.2023.
//

import Foundation


protocol BiteChooseNavigation : AnyObject{
    func chooseBite()
    func createNewBite()
}

class BiteChooseViewModel{
    
    weak var navigation : BiteChooseNavigation!
    var bites:[Bite]!
    var documentID:Int!
    
    init(navigationController : BiteChooseNavigation, bites:[Bite], documentID:Int) {
            self.navigation = navigationController
            self.bites = bites
            self.documentID = documentID
        }
    
   
}
