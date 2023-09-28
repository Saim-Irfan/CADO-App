//
//  CartVC.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class CartVC: UIViewController {
    static let storyboardIdentifier = "cartVC"
    
    
    
    private let cartItemManager = CartItemManager()
    
    override func viewDidAppear(_ animated: Bool) {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        
        let cartItems = cartItemManager.getAll(byUserId: loggedInUserId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
