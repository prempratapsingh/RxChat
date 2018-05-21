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
    
    var onlineUsers = Variable([User]())
    
    func getOnlineUserList() {
        
        UserModel.sharedInstance.getLoggedinUserList { [weak self] users in
            self?.onlineUsers.value.removeAll()
            for user in users {
               self?.onlineUsers.value.append(user)
            }
            
        }
    }
}
