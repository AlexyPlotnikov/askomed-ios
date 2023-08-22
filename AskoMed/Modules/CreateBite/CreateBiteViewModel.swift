//
//  CreateBiteViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import Foundation

protocol CreateBiteNavigation : AnyObject{
    func back()
    func hideNavBar()
    func biteCreated(bite:Bite)
}


class CreateBiteViewModel{
    weak var navigation: CreateBiteNavigation!
 
    init(navigationController : CreateBiteNavigation) {
            self.navigation = navigationController
           
        }
}
