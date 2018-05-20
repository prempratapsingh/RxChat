//
//  UserModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class UserModel: NSObject {
    
    static var sharedInstance = UserModel()
    
    override private init() {
        print("UserModel initialized!")
    }
    
    func loginUserWith(email: String, password: String, completionHandler: @escaping (_:Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User login successful for \(String(describing: Auth.auth().currentUser?.displayName!))")
                // Saving to local storage
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.isUserLoggedIn)
                completionHandler(true)
            } else {
                print("Error logging in user!")
                completionHandler(false)
            }
        }
    }
    
    func signupUserWith(name: String, email: String, password: String, completionHandler: @escaping (_:Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created!")
                print("User details: \(String(describing: user))")
                completionHandler(true)
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name updated!")
                    } else {
                        print("Error updating user display name! \(String(describing: error?.localizedDescription))")
                    }
                }
            } else {
                completionHandler(false)
            }
        }
    }
    
    func logoutUser(completionHandler: @escaping (_:Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                
                // Saving to local storage
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.isUserLoggedIn)
                
                completionHandler(true)
                
            } catch let error as NSError {
                completionHandler(false)
            }
        }
    }
}
