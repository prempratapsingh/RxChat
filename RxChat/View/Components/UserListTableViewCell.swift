//
//  UserListTableViewCell.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User?

    func setupView(user: User) {
        self.user = user
        
        guard let view = view, let nameLabel = nameLabel else {return}
        
        view.layer.cornerRadius = 10
        nameLabel.text = user.name
    }

}
