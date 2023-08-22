//
//  CreateImunoViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import Foundation


protocol CreateImunoNavigation : AnyObject{
    func back()
    func goResultView()
}

class CreateImunoViewModel{
    
    weak var navigation : CreateImunoNavigation!
    var model:AppealServiceSend!
    var boxes:[ApealImmunoglobulin] = [ApealImmunoglobulin(barcode: "", countMLIG: "")]
    
    init(navigationController : CreateImunoNavigation, model:AppealServiceSend) {
        self.navigation = navigationController
        self.model = model
    }
}

