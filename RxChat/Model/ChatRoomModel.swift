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
        
        let user = User()
        user.name = "New User"
        
        onlineUsers.value.append(user)
    }
}
