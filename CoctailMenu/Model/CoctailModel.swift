//
//  CoctailModel.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

struct Coctail: Decodable {
    
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case imageUrl = "strDrinkThumb"
    }
}

struct CoctailModel: Decodable {
    
    var drinks: [Coctail]
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}
