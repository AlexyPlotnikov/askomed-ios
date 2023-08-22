//
//  ServiceInfoViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import Foundation

protocol ServiceInfoNavigation : AnyObject{
    func back()
    func hideNavBar()
}


class ServiceInfoViewModel{
    weak var navigation: ServiceInfoNavigation!
    var model:ServiceInfoModel?
    var documentID:Int!
    
    init(navigationController : ServiceInfoNavigation, documentID:Int) {
            self.navigation = navigationController
            self.documentID = documentID
           
        }
}
