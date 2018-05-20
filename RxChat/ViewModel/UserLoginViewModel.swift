//
//  UserLoginViewModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class UserLoginViewModel: NSObject {
    
    var model: UserModel?
    weak var viewDelegate: UserLoginViewModelViewDelegate?
    weak var coordinatorDelegate: UserLoginViewModelCoordinatorDelegate?
    
    func loginUserWith(email: String, password: String) {
        
    }
    
    func showUserSignupView() {
        coordinatorDelegate?.showUserSignupView()
    }
}
