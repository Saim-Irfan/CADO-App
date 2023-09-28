//
//  ForgotPasswordVC.swift
//  Cado-App
//
//  Created by Saim on 26/09/2023.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    static let storyboardIdentifier = "forgotPasswordVC"
    
    @IBOutlet var emailTxtField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxtField.delegate = self
    }
    

    @IBAction func sendEmailBtnTapped(_ sender: PrimaryButton) {
        let alert = UIAlertController(title: "Please check your email", message: "We sent you a link to reset your password", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        
        present(alert, animated: true)
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
