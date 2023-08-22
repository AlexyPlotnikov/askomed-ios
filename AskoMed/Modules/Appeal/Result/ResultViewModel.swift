//
//  ResultViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import Foundation

protocol ResultNavigation : AnyObject{
    func backToMain()
}

class ResultViewModel{
    
    weak var navigation : ResultNavigation!
  
    
    init(navigationController : ResultNavigation) {
        self.navigation = navigationController
      
    }
}
