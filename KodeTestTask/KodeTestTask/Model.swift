//
//  Model.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 12.11.2021.
//

import Foundation


struct Items: Codable{
    var items : [value] = Array()
}


struct value: Codable, Hashable, Identifiable{
    var id : String
    var avatarUrl : String
    var firstName : String
    var lastName : String
    var userTag : String
    var department : String
    var position : String
    var birthday : String
    var phone : String
}
