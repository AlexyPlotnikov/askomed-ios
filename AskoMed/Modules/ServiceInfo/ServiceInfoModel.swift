//
//  ServiceInfoModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import Foundation


struct ServiceInfoModel:Codable{
    let title:String?
    let insuranceCompanyTitle:String?
    let items:[ServiceItem]?
}


struct ServiceItem:Codable{
    let title:String?
    let items:[SubserviceItem]?
}

struct SubserviceItem:Codable{
    let type:Int?
    let title:String?
    let information:String?
    let informationTagType:Int?
    let iconId:Int?
    let specialConditions:String?
}
