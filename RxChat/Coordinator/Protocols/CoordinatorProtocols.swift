//
//  CoordinatorProtocols.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

protocol UserLoginCoordinatorDelegate: class {
    func didCompleteUserLogin()
    func showUserSignupView()
}

protocol UserSignupCoordinatorDelegate: class {
    func didCompleteUseSignup()
    func showLogin()
}

protocol UserListCoordinatorDelegate: class {
    func showLoginViewAfterLogout()
}
