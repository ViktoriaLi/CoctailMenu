//
//  CategoryModel.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

struct Drink: Decodable {
    
    var category: String

    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
    }
}

struct FilterModel: Decodable {
    
    var drinks: [Drink]

    
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}
