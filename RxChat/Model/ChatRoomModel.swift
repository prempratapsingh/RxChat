//
//  ChatRoomModel.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import Foundation
import RxSwift

class ChatRoomModel: NSObject {
    
    var onlineUsers = PublishSubject<[User]>()
    
    func getOnlineUserList() {
        
        UserModel.sharedInstance.getLoggedinUserList { [weak self] users in
            if users.count > 0 {
                self?.onlineUsers.onNext(users)
            }
        }
    }
}
