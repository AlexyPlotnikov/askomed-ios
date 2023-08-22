//
//  AppealServiceModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 17.07.2023.
//

import Foundation

struct AppealServiceGet:Codable{
    var response:String?
}

struct AppealServiceSend:Codable{
      var dateBite:String
      var dateAppeal: String
      var immunocardId: Int
      var letterGuaranteeId: Int?  = nil
      var immunoglobulinumFromAsco: Bool = false
      var items: [Int]
      var patientWeight:Int?  = nil
      var countMLIG:Int?  = nil
      var noteIG:String?  = nil
      var immunoglobulinBoxUsed:[ApealImmunoglobulin]? = nil
    

}

struct ApealImmunoglobulin:Codable{
    var barcode:String?
    var countMLIG: String?
}
