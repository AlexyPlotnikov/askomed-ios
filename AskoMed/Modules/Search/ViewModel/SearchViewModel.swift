//
//  SearchViewModel.swift
//  AskoMed
//
//  Created by RX Group on 13.03.2023.
//

import Foundation
import UIKit


protocol SearchNavigation : AnyObject{
    func searchByParam(searchType:SearchEnum, results:PersonResultModel?, serachParam:SearchParam)
    func openQR()
}

class SearchViewModel{
    
    weak var navigation : SearchNavigation!
    var model:SearchEnum = SearchEnum(index: 0)
    var segmentIndex:Int = 0
    var paramSend = SearchParam(immunocard: false,fullName:"",dateBirth: "",series: "",number: "")
  
    
    init(navigationController : SearchNavigation) {
            self.navigation = navigationController
        }
    
    func getMulticolorText(text:String, isRequired:Bool) -> NSMutableAttributedString{
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 13), NSAttributedString.Key.foregroundColor : UIColor.init(displayP3Red: 97/255, green: 97/255, blue: 97/255, alpha: 1)]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 13), NSAttributedString.Key.foregroundColor : UIColor.init(displayP3Red: 240/255, green: 55/255, blue: 40/255, alpha: 1)]
        
        let attributedString1 = NSMutableAttributedString(string:text, attributes:attrs1 as [NSAttributedString.Key : Any])
        let attributedString2 = NSMutableAttributedString(string:" *", attributes:attrs2 as [NSAttributedString.Key : Any])
        if(isRequired){
            attributedString1.append(attributedString2)
        }
            return attributedString1
    }
}
