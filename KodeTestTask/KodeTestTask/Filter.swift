//
//  Filter.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 18.11.2021.
//

import Foundation

struct FilterItem : Identifiable, Hashable{
    var id = UUID().uuidString
    var title : String
    var checked : Bool
}
