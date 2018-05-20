//
//  UserListCoordinator.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit

class UserListCoordinator: Coordinator {
    
    var window: UIWindow?
    
    init(withWindow: UIWindow) {
        self.window = withWindow
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let userListVC = storyboard.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
        let userListViewModel = UserListViewModel()
        userListViewModel.coordinatorDelegate = self
        userListViewModel.model = ChatRoomModel()
        userListVC.viewModel = userListViewModel
        
        self.window?.rootViewController = userListVC
    }
}

extension UserListCoordinator: UserListViewModelCoordinatorDelegate {
    func showUserListView() {
        
    }
}
