//
//  AppCoordinator.swift
//  AskoMed
//
//  Created by RX Group on 09.03.2023.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
   
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        pushLogin()
    }

}

extension LoginCoordinator:LoginNavigation {
    
    func pushLogin(){
         let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginController
         
         let loginViewModel = LoginViewModel.init(navigationController: self)
         loginViewController.viewModel = loginViewModel
         navigationController.pushViewController(loginViewController, animated: true)
    }
    
    
    func authorization() {
       let parent = parentCoordinator as! AppCoordinator
        parent.goChooseMO()
        
        parentCoordinator?.childDidFinish(self)
    }
    

    
   
}
