//
//  ChooseCaseViewModel.swift
//  AskoMed
//
//  Created by RX Group on 04.04.2023.
//

import Foundation

protocol ChooseCaseNavigation : AnyObject{
    func chooseCase(services:ServicesAppeal, dates:(String, String), documentID:Int)
    func createBite(documentID:Int, bites:[Bite])
}

class ChooseCaseViewModel{
    
    weak var navigation : ChooseCaseNavigation!
    var documentID:Int!
    var bites:[Bite]!
    var currentBite:Bite?
    
    init(navigationController : ChooseCaseNavigation, documentID:Int, bites:[Bite]) {
            self.navigation = navigationController
            self.documentID = documentID
            self.bites = bites
        }
    
   
}
