//
//  User.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var name: String!
    var email: String!
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
