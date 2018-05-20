//
//  AppCoordinator.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var coordinators = [CoordinatorId:Coordinator]()
    var window: UIWindow!
    
    init(withWindow: UIWindow) {
        window = withWindow
    }
    
    func start() {
        if ApplicationModel.sharedInstance.isUserLoggedIn() {
            showUserListView()
        } else {
            showUserLoginView()
        }
    }
}

extension AppCoordinator: UserLoginCoordinatorDelegate {
    
    func showUserLoginView() {
        let userLoginCoordinator = UserLoginCoordinator(withWindow: window)
        coordinators[.userLogin] = userLoginCoordinator
        userLoginCoordinator.delegate = self
        userLoginCoordinator.start()
    }
    
    func showUserSignupView() {
        let userSignupCoordinator = UserSignupCoordinator(withWindow: window)
        coordinators[.userSignup] = userSignupCoordinator
        userSignupCoordinator.delegate = self
        userSignupCoordinator.start()
    }
    
    func didCompleteUserLogin() {
        coordinators[.userLogin] = nil
        showUserListView()
    }
    
    func showUserListView() {
        let userLoginCoordinator = UserLoginCoordinator(withWindow: window)
        coordinators[.userLogin] = userLoginCoordinator
        userLoginCoordinator.start()
    }
}

extension AppCoordinator: UserSignupCoordinatorDelegate {
    func didCompleteUseSignup() {
        coordinators[.userSignup] = nil
        showUserLoginView()
    }
    
    func showLogin() {
        coordinators[.userSignup] = nil
        showUserLoginView()
    }
}
