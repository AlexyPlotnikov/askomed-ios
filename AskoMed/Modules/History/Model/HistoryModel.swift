//
//  HistoryModel.swift
//  AskoMed
//
//  Created by RX Group on 16.03.2023.
//

import Foundation


struct HistoryResult:Insured{
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


class HistoryModel {
    
    var historyList:[HistoryResult]!
    
    convenience init(historyList:[HistoryResult]) {
        self.init()
        self.historyList = historyList
    }
    
}
