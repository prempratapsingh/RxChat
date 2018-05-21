//
//  UserLoginViewModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class UserLoginViewModel: NSObject {
    
    weak var viewDelegate: UserLoginViewModelViewDelegate?
    weak var coordinatorDelegate: UserLoginViewModelCoordinatorDelegate?
    
    var model: UserModel?
    var userEmail: String?
    var userPassword: String?
    
    func loginUser() {
        model?.loginUserWith(email: userEmail!, password: userPassword!) { [weak self] didLogin in
            if didLogin == true {
                self?.viewDelegate?.didCompleteUserLogin()
            } else {
                self?.viewDelegate?.didUserLoginFail()
            }
        }
    }
    
    func showUserSignupView() {
        coordinatorDelegate?.showUserSignupView()
    }
    
    func showUserListView() {
        coordinatorDelegate?.didCompleteUserLogin()
    }
}
