//
//  ViewController.swift
//  RxChat
//
//  Created by Prem Pratap Singh on 20/05/18.
//  Copyright © 2018 Prem Pratap Singh. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserLoginVC: UIViewController {

    var viewModel: UserLoginViewModel?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDelegate = self
        
        setupView()
        bindView()
    }
    
    func setupView() {
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        
        loginButton.layer.cornerRadius = 15
        loginButton.isUserInteractionEnabled = false
        loginButton.alpha = 0.7
    }
    
    func bindView() {
        
    }
    
    @IBAction func didClickOnLoginButton(_ sender: Any) {
        
    }
    
    @IBAction func didClickOnSignupButton(_ sender: Any) {
        viewModel?.showUserSignupView()
    }
}

extension UserLoginVC: UserLoginViewModelViewDelegate {
    func didCompleteUserLogin() {
        let alert = UIAlertController(title: "User Login", message: "Your login is successful!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true)
    }
    
    func didUserLoginFail() {
        let alert = UIAlertController(title: "User Login", message: "Your login failed, please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true)
    }
}

extension UserLoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

