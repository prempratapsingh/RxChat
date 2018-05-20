//
//  UserSignupVC.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa

class UserSignupVC: UIViewController {

    let bag = DisposeBag()
    var viewModel: UserSignupViewModel?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindView()
    }
    
    func setupView() {
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        
        signupButton.layer.cornerRadius = 15
        signupButton.isUserInteractionEnabled = false
        signupButton.alpha = 0.7
    }
    
    func bindView() {
        Observable.combineLatest(
            nameTextField.rx.text,
            emailTextField.rx.text,
            passwordTextField.rx.text,
            resultSelector: { [weak self] userName, userEmail, userPassword in
                if let name = userName, let email = userEmail, let password = userPassword {
                    if name.count > 0 && email.count > 0 && password.count > 0 {
                        self?.viewModel?.userName = name
                        self?.viewModel?.userEmail = email
                        self?.viewModel?.password = password
                        
                        self?.signupButton.isUserInteractionEnabled = true
                        self?.signupButton.alpha = 0.7
                    }
                }
        }).subscribe().disposed(by: bag)
    }
    
    @IBAction func didClickOnSignupButton(_ sender: Any) {
        SVProgressHUD.show()
        viewModel?.signupUser()
    }
    
    @IBAction func didClickOnBackButton(_ sender: Any) {
        viewModel?.showUserLoginView()
    }
    
}

extension UserSignupVC: UserSignupViewModelViewDelegate {
    func didCompleteUserSignup() {
        SVProgressHUD.dismiss()
    }
    
    func didUserSignupFail() {
        SVProgressHUD.dismiss()
    }
}

extension UserSignupVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
