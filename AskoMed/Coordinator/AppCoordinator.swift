//
//  AppCoordinator.swift
//  CoordinatorTutorial
//
//  Created by BobbyPhtr on 13/04/21.
//

import Foundation
import UIKit

class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
       goToAuth()
    }
    
    func goToAuth(){
        authToken = UserDefaults.standard.string(forKey: "token")
   
        if(self.checkValidToken(token: authToken)){
            let chooseCoordinator = ChooseMOCoordinator.init(navigationController: navigationController)
            chooseCoordinator.parentCoordinator = self
            children.append(chooseCoordinator)
            
            chooseCoordinator.start()
        }else{
            let authCoordinator = LoginCoordinator.init(navigationController: navigationController)
            authCoordinator.parentCoordinator = self
            children.append(authCoordinator)
            
            authCoordinator.start()
        }
        
    }
    
    func goChooseMO(){
        let chooseCoordinator = ChooseMOCoordinator.init(navigationController: navigationController)
        chooseCoordinator.parentCoordinator = self
        children.append(chooseCoordinator)
        
        chooseCoordinator.start()
    }
    
    func goToHome(){
        let coordinator = HomeTabBarCoordinator.init(navigationController: navigationController)
        coordinator.parentCoordinator = self
        children.append(coordinator)
        
        coordinator.start()
    }
    
    deinit {
        print("AppCoordinator Deinit")
    }
    
    
    func checkValidToken(token:String?) -> Bool{
        if(token == nil){
            return false
        }
        var payload64 = (authToken ?? "").components(separatedBy: ".")[1]
        while payload64.count % 4 != 0 {
            payload64 += "="
        }
        let payloadData = Data(base64Encoded: payload64,
                               options:.ignoreUnknownCharacters)!
       
        let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
        let exp = json["exp"] as! Int
        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
        let isValid = expDate.compare(Date()) == .orderedDescending
        return isValid
    }
    
}
