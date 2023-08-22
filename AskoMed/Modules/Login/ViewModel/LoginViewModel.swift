//
//  LoginViewModel.swift
//  AskoMed
//
//  Created by RX Group on 09.03.2023.
//

import Foundation

protocol LoginNavigation : AnyObject{
    func authorization()
}

class LoginViewModel {
    
    weak var navigation : LoginNavigation!
    
    init(navigationController : LoginNavigation) {
            self.navigation = navigationController
        }
    
    func authorization(){
        self.navigation.authorization()
    }
}
