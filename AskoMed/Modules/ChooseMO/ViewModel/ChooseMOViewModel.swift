//
//  ChooseMOViewModel.swift
//  AskoMed
//
//  Created by RX Group on 10.03.2023.
//

import Foundation

protocol ChooseNavigation : AnyObject{
    func chooseMO(mo:Int)
}

class ChooseMOViewModel{
    
    weak var navigation : ChooseNavigation!
    var model:[Hospital]!
    
    init(navigationController : ChooseNavigation) {
            self.navigation = navigationController
        }
    
    func chooseMO(mo:Int){
        self.navigation.chooseMO(mo: mo)
    }
}
