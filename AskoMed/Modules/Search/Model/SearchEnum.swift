//
//  SearchEnum.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchTableModel{
    var topField:FieldModel
    var bottomField:FieldModel
}

struct FieldModel{
    var fieldTitle:String
    var fieldPlaceholder:String
    var isRequired:Bool
}


enum SearchEnum {
    case police
    case card
   
    
    init(index: Int) {
        switch index {
        case 0:
            self = .police
        case 1:
            self = .card
       
        default:
            self = .police
        }
    }
    
    func searchTitleValue() -> SearchTableModel {
        switch self {
        case .police:
            return SearchTableModel(topField: FieldModel(fieldTitle: "ФИО застрахованного", fieldPlaceholder: "ФИО застрахованного", isRequired: true), bottomField: FieldModel(fieldTitle: "Дата рождения", fieldPlaceholder: "дд.мм.гггг", isRequired: true))
        case .card:
            return SearchTableModel(topField: FieldModel(fieldTitle: "Серия иммунокарты", fieldPlaceholder: "xx-xxx", isRequired: true), bottomField: FieldModel(fieldTitle: "Номер иммунокарты", fieldPlaceholder: "№xxxxxx", isRequired: true))
        }
    }
}


struct SearchParam:Codable{
    var immunocard:Bool
    var fullName:String
    var dateBirth:String
    var series:String
    var number:String
}


