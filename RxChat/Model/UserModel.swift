//
//  UserModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    static var sharedInstance = UserModel()
    
    override private init() {
        // Initializng UserModel
    }
    
    var user: User? {
        get {
            return UserService.sharedInstance.user
        }
    }
    
    func loginUserWith(email: String, password: String, completionHandler: @escaping (_:Bool) -> Void) {
        UserService.sharedInstance.loginUserWith(email: email, password: password) { didLogin, user in
            completionHandler(didLogin)
        }
    }
    
    func signupUserWith(name: String, email: String, password: String, completionHandler: @escaping (_:Bool) -> Void) {
        UserService.sharedInstance.signupUserWith(name: name, email: email, password: password) { didSignup in
            completionHandler(didSignup)
        }
    }
    
    func logoutUser(completionHandler: @escaping (_:Bool) -> Void) {
        UserService.sharedInstance.logoutUser { isLoggedOut in
            completionHandler(isLoggedOut)
        }
    }
    
    func getLoggedinUserList(completionHandler: @escaping ([User]) -> Void) {
        UserService.sharedInstance.getLoggedinUserList { users in
            completionHandler(users)
        }
    }
}
