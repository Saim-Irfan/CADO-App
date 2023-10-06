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
    @IBOutlet var browseGiftLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureConfirmationMessage()
        configureBrowseGiftLabel()
    }
    
    func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(removeScreen))
        navigationItem.title = ""
        navigationItem.hidesBackButton = true
    }
    
    func configureConfirmationMessage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(confirmationMsgTapped(gesture:)))
        confirmationLbl.addGestureRecognizer(tapGesture)
        confirmationLbl.isUserInteractionEnabled = true
    }
    
    func configureBrowseGiftLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeScreen))
        browseGiftLbl.addGestureRecognizer(tapGesture)
        browseGiftLbl.isUserInteractionEnabled = true
    }
    
    @objc func removeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func confirmationMsgTapped(gesture: UITapGestureRecognizer) {
        let text = (confirmationLbl.text)!
        let myOrdersTextRange = (text as NSString).range(of: "My Orders")
        
        if gesture.didTapAttributedTextInLabel(label: confirmationLbl, inRange: myOrdersTextRange) == false {
            return
        }
        
        guard var viewControllerList = navigationController?.viewControllers else {
            return
        }
        
        guard let mainTabBarVC = navigationController?.viewControllers.first(where: { viewController in
            viewController is UITabBarController
        }) as? UITabBarController else {
            return
        }
        
        mainTabBarVC.selectedIndex = CartVC.tabbarIndex
        viewControllerList.removeLast()
        
        navigationController?.setViewControllers([mainTabBarVC], animated: true)
    }
    
    
}
