//
//  MainTabBarController.swift
//  TZB
//
//  Created by RX Group on 02.08.2022.
//

import UIKit

class MainTabBarController: UITabBarController, Storyboardable {
  
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.init(displayP3Red: 12/255, green: 175/255, blue: 137/255, alpha: 1)
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }

    }
    
    func setupVCs(viewControllers:[UIViewController]) {
        self.setViewControllers(viewControllers, animated: true)
     
    }
   
}
