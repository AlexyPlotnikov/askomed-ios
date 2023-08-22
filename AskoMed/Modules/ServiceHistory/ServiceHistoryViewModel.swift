//
//  ServiceHistoryViewModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 16.07.2023.
//

import Foundation

protocol ServiceHistoryNavigation : AnyObject{
    func back()
    func hideNavBar()
}


class ServiceHistoryViewModel{
    weak var navigation: ServiceHistoryNavigation!
    var appeal:AppealItem!
   
    init(navigationController : ServiceHistoryNavigation, appeal:AppealItem) {
            self.navigation = navigationController
            self.appeal = appeal
        }
}
