//
//  ChooseCoordinator.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import Foundation
import UIKit
import Alamofire

class ChooseMOCoordinator:Coordinator{
    var parentCoordinator: Coordinator?
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        self.loadHospitals()
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
   
    func loadHospitals(){
        let headers: HTTPHeaders = [
            "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
            "Authorization": "Bearer \(authToken ?? "")"]
   
        AF.request(domain + "/mobileapp/doctorhospitals", method: .get, headers: headers).responseDecodable(of: [Hospital].self){
            result in
            
            self.startChooseMO(hospitals: try? result.result.get())
        }
    }
    
}



extension ChooseMOCoordinator:ChooseNavigation{
    
    func startChooseMO(hospitals:[Hospital]?){
        if((hospitals ?? []).count  > 1){
            let moViewController = storyboard.instantiateViewController(withIdentifier: "chooseMO") as! ChooseMOController
            
            let moViewModel = ChooseMOViewModel.init(navigationController: self)
            moViewModel.model = hospitals!
            moViewController.viewModel = moViewModel
            navigationController.pushViewController(moViewController, animated: true)
        }else{
            self.chooseMO(mo: hospitals?[0].hospitalId ?? 0)
        }
    }
    
    func chooseMO(mo: Int) {
        let headers: HTTPHeaders = [
            "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
            "Authorization": "Bearer \(authToken ?? "")"]
        print(authToken!)
        AF.request(domain + "/mobileapp/doctorselecthospital?hospitalId=\(mo)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response(completionHandler: {
            result in
            print(result)
        })

       
        
        let parent = parentCoordinator as! AppCoordinator
        parent.goToHome()
        parentCoordinator?.childDidFinish(self)
    }
    
    
}
