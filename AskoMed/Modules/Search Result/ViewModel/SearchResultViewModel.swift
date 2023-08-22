//
//  SearchResultViewModel.swift
//  AskoMed
//
//  Created by RX Group on 23.03.2023.
//

import Foundation

protocol SearchResultNavigation : AnyObject{
    func back()
    func chooseResult(person:Insured)
}

class SearchResultViewModel{
    
    weak var navigation : SearchResultNavigation!
    var model:PersonResultModel!
    var searchParam:SearchParam!
    
    init(navigationController : SearchResultNavigation) {
            self.navigation = navigationController
        }
    
  
}
