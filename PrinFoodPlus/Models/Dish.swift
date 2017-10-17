//
//  Dish.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/16/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import Foundation

enum DishType {
    case regular, vegetarian, vegan
}

struct Dish {
    let name: String
    let type: DishType
    let course: Int
    
    init(name: String, dictionary: [String: Any]) {
        self.name = name
        
        switch dictionary["type"] as? Int {
        case 1?:
            type = .vegetarian
        case 2?:
            type = .vegan
        default:
            type = .regular
        }
        
        self.course = dictionary["course"] as? Int ?? 0
    }
}
