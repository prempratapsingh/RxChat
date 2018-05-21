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
import FirebaseDatabase

class UserModel: NSObject {
    
    static var sharedInstance = UserModel()
    var userDatabase = DatabaseReference.init()
    
    override private init() {
        // Initializing user database
        userDatabase = Database.database().reference()
    }
    
    func loginUserWith(email: String, password: String, completionHandler: @escaping (_:Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error == nil && user != nil {
                
                let userName = Auth.auth().currentUser?.displayName ?? user?.user.displayName
                print("User login successful for \(userName))")
                
                // Saving to local storage
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.isUserLoggedIn)
                
                // Adding user login session to the database
                let loginDetails = [
                    "userName" : userName,
                    "lastLoginTime" : ServerValue.timestamp()
                ] as [String:Any]
                
                self?.userDatabase.child(FirebaseDatabaseNodes.userLogin).childByAutoId().setValue(loginDetails)
                
                // Reponding back to the view model
                completionHandler(true)
            } else {
                print("Error logging in user!")
                
                // Reponding back to the view model
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
