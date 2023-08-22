//
//  Storybordable.swift
//  AskoMed
//
//  Created by RX Group on 13.03.2023.
//

import Foundation
import UIKit



protocol Storyboardable {
    static func createMenu(with identifire:String) -> Self
    static func createSearch(with identifire:String) -> Self
    static func createPolice(with identifire:String) -> Self
    static func createAppeal(with identifire:String) -> Self
    static func createProfile(with identifire:String) -> Self
    static func createDirectory(with identifire:String) -> Self
}

extension Storyboardable where Self: UIViewController {
    
    static func createMenu(with identifire:String) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifire) as! Self
    }
    
    static func createSearch(with identifire:String) -> Self{
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifire) as! Self
    }
    
    static func createPolice(with identifire:String) -> Self{
        let storyboard = UIStoryboard(name: "Police", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifire) as! Self
    }
    
    static func createAppeal(with identifire:String) -> Self{
        let storyboard = UIStoryboard(name: "Appeal", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifire) as! Self
    }
  
    static func createProfile(with identifire:String) -> Self{
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifire) as! Self
    }
    
    static func createDirectory(with identifire:String) -> Self{
        let storyboard = UIStoryboard(name: "Directory", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifire) as! Self
    }
}
