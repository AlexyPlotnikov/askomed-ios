//
//  LoginModel.swift
//  AskoMed
//
//  Created by RX Group on 04.05.2023.
//

import Foundation

struct TokenJson:Codable{
    var token:String
}

struct Login: Encodable {
    let login: String
    let password: String
}


