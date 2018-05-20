//
//  UserListVC.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit
import RxSwift

class UserListVC: UIViewController {

    @IBOutlet weak var userListTableView: UITableView!
    
    let bag = DisposeBag()
    var viewModel: UserListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDelegate = self
        setupView()
        bindView()
        
        viewModel?.getOnlineUserList()
    }
    
    private func setupView() {
        userListTableView.delegate = self
        userListTableView.dataSource = self
    }
    
    private func bindView() {
        viewModel?.model?.onlineUsers.asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.userListTableView.reloadData()
            }).disposed(by: bag)
    }
    
    @IBAction func didClickOnRefreshButton(_ sender: Any) {
        viewModel?.getOnlineUserList()
    }
}

extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel?.model?.onlineUsers.value.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell {
            if let users = viewModel?.model?.onlineUsers.value {
                let user = users[indexPath.row]
                let cell = UserListTableViewCell()
                cell.setupView(user: user)
                return cell
            }
        }
            
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO navigate to chat room VC
    }
}

extension UserListVC: UserListViewModelViewDelegate {
    func didUserListLoaded() {
        // show in view
    }
    
    func didUserListLoadFailed() {
        // show error message
    }
}


