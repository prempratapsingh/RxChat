//
//  UserSignupViewModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class UserSignupViewModel: NSObject {
    
    weak var viewDelegate: UserSignupViewModelViewDelegate?
    weak var coordinatorDelegate: UserSignupViewModelCoordinatorDelegate?
    
    var model: UserModel?
    var userName: String?
    var userEmail: String?
    var password: String?
    
    func showUserLoginView() {
        coordinatorDelegate?.showUserLoginView()
    }
    
    func signupUser() {
        model?.signupUserWith(name: userName!, email: userEmail!, password: password!) { didSignup in 
            
        }
    }
}
