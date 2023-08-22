//
//  SeroprophylacticsViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import Foundation


protocol SeropropylacticsNavigation : AnyObject{
    func back()
    func createImuno(model:AppealServiceSend)
}

class SeroprohylacticsViewModel{
    
    weak var navigation : SeropropylacticsNavigation!
    var model:AppealServiceSend!
    var needComment:Bool = false
   
    
    init(navigationController : SeropropylacticsNavigation, model:AppealServiceSend) {
        self.navigation = navigationController
        self.model = model
    }
}
