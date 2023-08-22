//
//  ChooseCaseModel.swift
//  AskoMed
//
//  Created by Алексей Плотников on 17.07.2023.
//

import Foundation


struct SendChooseAppeal:Codable{
    var documentid:Int
    var letterGuaranteeId:Int
}

struct ServicesAppeal:Codable{
    var immunoglobulinumFromAsco:Bool?
    var minimalDateBite:String?
    var sections:[SectionAppeal]?
    var services: [ServicesSection]?
}

struct SectionAppeal:Codable{
    var id: Int?
    var title: String?
}

struct ServicesSection:Codable{
    var seroprofilactic:Bool?
    var sectionId:Int?
    var linkPriceServicesId:Int?
    var servicesPrice: [String]?
    var servicesSystem:[String]?
}
