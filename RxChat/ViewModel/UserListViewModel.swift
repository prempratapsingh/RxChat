//
//  UserListViewModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation

class UserListViewModel: NSObject {
    
    var model: ChatRoomModel?
    
    weak var viewDelegate: UserListViewModelViewDelegate?
    weak var coordinatorDelegate: UserListViewModelCoordinatorDelegate?
    
    func getOnlineUserList() {
        model?.getOnlineUserList()
    }
}
