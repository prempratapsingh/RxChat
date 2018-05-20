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
        viewModel?.viewDelegate = self
        
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
        signupButton.alpha = 0.6
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
                        self?.signupButton.alpha = 1.0
                    } else {
                        self?.signupButton.isUserInteractionEnabled = false
                        self?.signupButton.alpha = 0.6
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
        
        let alert = UIAlertController(title: "User Signup", message: "Your app account is created. Please login with email and password!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self] action in
            alert.dismiss(animated: true, completion: nil)
            self?.viewModel?.showUserLoginView()
        })
        present(alert, animated: true)
    }
    
    func didUserSignupFail() {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "User Signup", message: "Sorry, Your app account coundn't be created. Please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true)
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
