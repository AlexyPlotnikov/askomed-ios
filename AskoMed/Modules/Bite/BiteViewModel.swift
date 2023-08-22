//
//  BiteViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 16.07.2023.
//

import Foundation


protocol BiteNavigation : AnyObject{
    func back()
    func hideNavBar()
}


class BiteViewModel{
    weak var navigation: BiteNavigation!
    var bites:[Bite]!
    
    init(navigationController : BiteNavigation, bites:[Bite]) {
            self.navigation = navigationController
            self.bites = bites
        }
}
