//
//  UserSignupCoordinator.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit

class UserSignupCoordinator: Coordinator {
    
    var window: UIWindow!
    weak var delegate: UserSignupCoordinatorDelegate?
    
    init(withWindow: UIWindow) {
        window = withWindow
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let signupVC = storyboard.instantiateViewController(withIdentifier: "UserSignupVC") as! UserSignupVC
        let signupViewModel = UserSignupViewModel()
        signupViewModel.coordinatorDelegate = self
        signupViewModel.model = UserModel.sharedInstance
        signupVC.viewModel = signupViewModel
        
        self.window.rootViewController = signupVC
    }
}

extension UserSignupCoordinator: UserSignupViewModelCoordinatorDelegate {
    func showUserLoginView() {
        delegate?.showLogin()
    }
}
