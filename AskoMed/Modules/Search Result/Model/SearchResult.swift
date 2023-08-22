//
//  SearchResult.swift
//  AskoMed
//
//  Created by RX Group on 24.03.2023.
//

import Foundation


struct PersonResultModel:Codable{
    var items:[Person]
}

struct Person:Insured{
    var documentId: Int?
    
    var fullName: String?
    
    var dateBirth: String?
    
    var series: String?
    
    var number: String?
    
    var numberPolicy: String?
    
    var dateCreate: String?
    
    var pathLogoInsuranceCompany: String?
    
    var tags: [TagInsured]
    
}



class SearchResultModel {
    
    var resultsList:PersonResultModel!
    
    
    convenience init(resultsList:PersonResultModel) {
        self.init()
        self.resultsList = resultsList
    }
    
}
