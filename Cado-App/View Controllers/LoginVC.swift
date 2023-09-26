//
//  LoginVC.swift
//  Cado-App
//
//  Created by Saim on 22/09/2023.
//

import UIKit

class LoginVC: UIViewController {
    static let storyboardIdentifier = "loginVC"

    @IBOutlet var takeToRegisterLbl: UILabel!
    
    
    @IBOutlet var mainErrorLbl: UILabel!
    
    @IBOutlet var emailTxtField: CustomTextField!
    @IBOutlet var passwordTxtField: CustomTextField!
    
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldDelegates()
        configureToRegisterLbl()
        configurePasswordFieldRightView()
    }
    
    func configureTextFieldDelegates() {
        emailTxtField.delegate      = self
        passwordTxtField.delegate   = self
    }
    
    func configureToRegisterLbl() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toRegisterScreen))
        
        takeToRegisterLbl.isUserInteractionEnabled = true
        takeToRegisterLbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func toRegisterScreen() {
        let registerVC = storyboard?.instantiateViewController(withIdentifier: RegisterVC.storyboardIdentifier) as! RegisterVC
        
        if var viewControllers = navigationController?.viewControllers {
            viewControllers.removeLast()
            viewControllers.append(registerVC)
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
    
    
    func configurePasswordFieldRightView() {
        let forgotPasswordLabel = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "Forgot?")
        attributedString.addAttribute(.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        forgotPasswordLabel.attributedText = attributedString
                
        passwordTxtField.rightViewMode = .always
        passwordTxtField.rightView = forgotPasswordLabel
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordLblTapped))
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
        forgotPasswordLabel.isUserInteractionEnabled = true
    }
    
    @objc func forgotPasswordLblTapped() {
        let forgotPasswordVC = storyboard?.instantiateViewController(withIdentifier: ForgotPasswordVC.storyboardIdentifier) as! ForgotPasswordVC
        
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        let email = emailTxtField.text!
        let password = passwordTxtField.text!
        
        guard let userWithEmail = userManager.findBy(email: email) else {
            mainErrorLbl.showWarningLabel(text: "User does not exists")
            return
        }
        
        if userWithEmail.password != password {
            mainErrorLbl.showWarningLabel(text: "Wrong Password")
            return
        }
        
        mainErrorLbl.hideLabel()
        
        let mainTabBarVC = storyboard?.instantiateViewController(withIdentifier: "mainTabBarVC") as! UITabBarController
        guard var viewControllerList = navigationController?.viewControllers else {
            return
        }
        
        viewControllerList.removeLast()
        viewControllerList.append(mainTabBarVC)
        
        navigationController?.setViewControllers(viewControllerList, animated: true)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
