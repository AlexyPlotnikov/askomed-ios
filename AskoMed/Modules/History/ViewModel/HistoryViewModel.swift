//
//  HistoryViewModel.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import Foundation

protocol HistoryNavigation : AnyObject{
   
}

class HistoryViewModel {
    
    weak var navigation : HistoryNavigation!
    var model:HistoryModel = HistoryModel()
    
    init(navigationController : HistoryNavigation) {
            self.navigation = navigationController
        }
    
   
}
