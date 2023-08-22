//
//  PersonInfoModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import Foundation

struct PersonCellModel{
    var title:String
    var desc:String
    var icon:String
    var key:String
}

struct PersonInfoDetail:Codable{
    let documentId:Int?
    let immunocard:Bool
    let dateBirth:String?
    let phone:String?
    let insuranceCompany:String?
    let insuranceProgram:String?
    let series:String?
    let number:String?
    let numberPolicy:String?
    let dateStart:String?
    let dateEnd:String?
    let status:String?
    let regionInsuranceCompany:String?
    let regionSale:String?
    let policyholder:String?
   // let photosViews": []
}
