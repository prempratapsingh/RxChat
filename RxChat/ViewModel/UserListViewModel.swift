//
//  UserListViewModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation
import RxSwift

class UserListViewModel: NSObject {
    
    var model = ChatRoomModel()
    
    weak var viewDelegate: UserListViewModelViewDelegate?
    weak var coordinatorDelegate: UserListViewModelCoordinatorDelegate?
    
    var usersObservable: Observable<[User]> {
        return self.model.onlineUsers.asObservable()
    }
    
    func getOnlineUserList() {
        model.getOnlineUserList()
    }
    
    func logoutUser() {
        UserModel.sharedInstance.logoutUser { [weak self] didLogOut in 
            if didLogOut == true {
                self?.viewDelegate?.didLogoutSuccessfully()
            } else {
                self?.viewDelegate?.didLogutFailed()
            }
        }
    }
    
    func showUserLoginView() {
        coordinatorDelegate?.showUserLoginView()
    }
}
