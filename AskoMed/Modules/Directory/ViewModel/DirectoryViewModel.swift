//
//  DirectoryViewModel.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import Foundation


protocol DirectoryNavigation : AnyObject{
   
}

class DirectoryViewModel {
    
    weak var navigation : DirectoryNavigation!
    
    init(navigationController : DirectoryNavigation) {
            self.navigation = navigationController
        }
    
}
