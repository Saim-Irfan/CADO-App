//
//  ConfirmationVC.swift
//  Cado-App
//
//  Created by Saim on 05/10/2023.
//

import UIKit

class ConfirmationVC: UIViewController {
    static let storyboardIdentifier = "confirmationVC"

    @IBOutlet var confirmationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureConfirmationMessage()
    }
    
    func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(removeScreen))
        navigationItem.title = ""
        navigationItem.hidesBackButton = true
    }
    
    func configureConfirmationMessage() {
        let text = (confirmationLbl.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let textRange = (text as NSString).range(of: "My Orders")
        underlineAttriString.addAttribute(.underlineStyle, value: 1, range: textRange)
        
        confirmationLbl.attributedText = underlineAttriString
    }

    @objc func removeScreen() {
        navigationController?.popViewController(animated: true)
    }
}
