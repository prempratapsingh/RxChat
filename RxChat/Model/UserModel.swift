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
    
    func loginUserWith(email: String, password: String) {
        // Call login API
    }
    
    func signupUserWith(name: String, email: String, password: String, completionHandler: (didSignupSucceed: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created!")
                print("User details: \(String(describing: user))")
                
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
                var message = "Couldn't signup due to server error, please try again later."
                if let msg = error?.localizedDescription {
                    message = msg
                }
            }
        }
    }
}
