//
//  Insured.swift
//  AskoMed
//
//  Created by RX Group on 24.03.2023.
//

import Foundation
import UIKit

enum DocumentTypeEnum{
    case police
    case paper
    case electronic
    case guarantee
    
    init(index: Int) {
        switch index {
        case 0:
            self = .police
        case 1:
            self = .paper
        case 2:
            self = .electronic
        case 3:
            self = .guarantee
       
        default:
            self = .police
        }
    }
    
    func policeTitle() -> String {
            switch self {
            case .police:
                return "Полис"
            case .paper:
                return "Бумажная"
            case .electronic:
                return "Электронная"
            case .guarantee:
                return "Зеленый пункт"
            }
    }
    
    func documentTypeColor() -> UIColor{
        switch self {
        case .police:
            return UIColor.init(displayP3Red: 103/255, green: 155/255, blue: 255/255, alpha: 1)
        case .paper:
            return UIColor.init(displayP3Red: 87/255, green: 114/255, blue: 255/255, alpha: 1)
        case .electronic:
            return UIColor.init(displayP3Red: 140/255, green: 121/255, blue: 255/255, alpha: 1)
        case .guarantee:
            return UIColor.init(displayP3Red: 87/255, green: 114/255, blue: 255/255, alpha: 1)
        }
    }
}

enum DocumentHistoryEnum{
    case active
    case inactive
    case wait
    case canceled
    case onlyPolice
    
    init(index: Int) {
        switch index {
        case 0:
            self = .active
        case 1:
            self = .inactive
        case 2:
            self = .wait
        case 3:
            self = .canceled
        case 4:
            self = .onlyPolice
       
        default:
            self = .active
        }
    }
    
    func historyTitle() -> String {
            switch self {
            case .active:
                return "Активная"
            case .inactive:
                return "Неактивная"
            case .wait:
                return "Ожидает активации"
            case .canceled:
                return "Аннулирована"
            case .onlyPolice:
                return "Действует только полис"
            }
        }
    
    func documentHistoryColor() -> UIColor{
        switch self {
        case .active:
            return UIColor.init(displayP3Red: 12/255, green: 175/255, blue: 137/255, alpha: 1)
        case .inactive:
            return UIColor.init(displayP3Red: 249/255, green: 96/255, blue: 90/255, alpha: 1)
        case .wait:
            return UIColor.init(displayP3Red: 255/255, green: 191/255, blue: 96/255, alpha: 1)
        case .canceled:
            return UIColor.init(displayP3Red: 249/255, green: 96/255, blue: 90/255, alpha: 1)
        case .onlyPolice:
            return UIColor.init(displayP3Red: 249/255, green: 96/255, blue: 90/255, alpha: 1)
        }
    }
}

protocol Insured:Codable{
    var documentId:Int? { get set }
    var fullName:String? { get set }
    var dateBirth:String? { get set }
    var series: String? { get set }
    var number:String? { get set }
    var numberPolicy:String? { get set }
    var dateCreate:String? { get set }
    var pathLogoInsuranceCompany:String? { get set }
    var tags:[TagInsured] { get set }
}

struct TagInsured:Codable{
    var title:String?
    var backGroundColor:String?
    var textColor:String?
}


//{
//       "documentId": 694950,
//       "fullName": "Русаков Илья Павлович",
//       "dateBirth": "1988-06-24T00:00:00",
//       "series": "54-434",
//       "number": "0078890",
//       "numberPolicy": "М98-009587/23",
//       "dateCreate": "2023-02-06T06:14:18.151823",
//       "pathLogoInsuranceCompany": "https://lk.imkart.ru/InsuranceCompanyLogo/Согласие.png",
//       "tags": [
//           {
//               "title": "Электронная",
//               "backGroundColor": "#8C79FF",
//               "textColor": "#ffffff"
//           },
//           {
//               "title": "Активна",
//               "backGroundColor": "#0CAF89",
//               "textColor": "#ffffff"
//           }
//       ]
//   }
