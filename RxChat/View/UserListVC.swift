//
//  UserListVC.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 21/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class UserListVC: UIViewController {

    @IBOutlet weak var userListTableView: UITableView!
    
    var viewModel = UserListViewModel()
    
    private let bag = DisposeBag()
    fileprivate var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDelegate = self
        
        setupView()
        bindView()
        loadUsers()
    }
    
    private func setupView() {
        userListTableView.delegate = self
        userListTableView.dataSource = self
    }
    
    private func bindView() {
        viewModel.usersObservable
            .subscribe(onNext: { [weak self] users in
                SVProgressHUD.dismiss()
                self?.users = users
                self?.userListTableView.reloadData()
            }).disposed(by: bag)
    }
    
    private func loadUsers() {
        SVProgressHUD.show()
        viewModel.getOnlineUserList()
    }
    
    @IBAction func didClickOnRefreshButton(_ sender: Any) {
        SVProgressHUD.show()
        viewModel.getOnlineUserList()
    }
    
    @IBAction func didClickOnLogoutButton(_ sender: Any) {
        SVProgressHUD.show()
        viewModel.logoutUser()
    }
}

extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell {
            let user = users[indexPath.row]
            cell.setupView(user: user)
            return cell
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
    
    func didLogoutSuccessfully() {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "User Logout", message: "You successfully logged out!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self] action in
            alert.dismiss(animated: true, completion: nil)
            self?.viewModel.showUserLoginView()
        })
        present(alert, animated: true)
    }
    
    func didLogutFailed() {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "User Logout", message: "Logout failed, please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true)
    }
}


