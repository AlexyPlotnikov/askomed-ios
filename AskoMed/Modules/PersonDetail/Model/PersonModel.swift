//
//  PersonModel.swift
//  AskoMed
//
//  Created by RX Group on 27.03.2023.
//

import Foundation
import UIKit

struct AppealSend:Encodable{
    var documentId:Int
    var biteId:Int
}

struct Appeal:Codable{
    
    let documentId:Int?
    let biteId:Int?
    let bites:[Bite]?
    let items:[AppealItem]?
}
struct AppealItem:Codable{
    let appealId:Int?
    let biteId:Int?
    let dateCreate:String?
    let services:[BiteSrvices]?
    let dateBite:String?
    let dateApplication:String?
    let hospitalTitle:String?
    let hospitalAddress:String?
}

struct Bite:Codable{
    let biteId:Int?
    let dateBite:String?
    
}

struct BiteSrvices:Codable{
    let serviceId:Int?
    let title:String?
    let icon:String?
    let weight:Int?
    let countIG:Int?
    let noteIG:String?
    let items:[BiteItem]?
}

struct BiteItem:Codable{
    let title:String?
    let discovery:Bool?
    let discoveryResult:Bool?
}

    
   

struct PersonInfo:Insured, Codable {
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



class PersonModel{
    var person:Insured!
    
    convenience init(person:Insured) {
        self.init()
        self.person = person
    }
}
