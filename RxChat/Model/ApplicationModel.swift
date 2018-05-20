//
//  ApplicationModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class ApplicationModel: NSObject {
    
    static var sharedInstance = ApplicationModel()
    
    override private init() {
        print("ApplicationModel initialized!")
    }
    
    func isUserLoggedIn() -> Bool {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserLoggedIn)
        return isLoggedIn
    }
}
