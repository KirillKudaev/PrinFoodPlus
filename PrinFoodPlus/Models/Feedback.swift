//
//  Feedback.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 2/16/18.
//  Copyright © 2018 Kirill Kudaev. All rights reserved.
//

import Foundation

struct Feedback {
    
    let content: String
    let email: String?
    
    init(content: String, email: String?) {
        self.content = content
        self.email = email
    }
}
