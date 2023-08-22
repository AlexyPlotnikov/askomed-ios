//
//  ProfileViewModel.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import Foundation


protocol ProfileNavigation : AnyObject{
    func chooseMO()
    func logOut()
}


class ProfileViewModel{
    weak var navigation:ProfileNavigation!
    var profile:ProfileModel!
    
    init(navigationController: ProfileNavigation!) {
        self.navigation = navigationController
    }
}
