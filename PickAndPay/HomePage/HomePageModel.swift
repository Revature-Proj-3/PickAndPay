//
//  HomePageModel.swift
//  PickAndPay
//
//  Created by admin on 7/1/22.
//

import Foundation

struct Product : Codable {
    var title : String
    var price : Double
    var description : String
    var category : String
    var image : String
    var rating : Rating
    
}

struct Rating : Codable {
    var rate : Double
    var count : Int
}

func ==(_ p1 : Product, _ p2 : Product) -> Bool {
    return p1.title == p2.title
}
