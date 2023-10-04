//
//  CartVC.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class CartVC: UIViewController {
    static let storyboardIdentifier = "cartVC"
    
    @IBOutlet var totalItemLbl: UILabel!
    @IBOutlet var cartItemTableView: UITableView!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    private let productManager = ProductManager()
    private let cartItemManager = CartItemManager()
    
    private var cartItems: [CartItem] = []
    
    override func viewDidAppear(_ animated: Bool) {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.cartItems = cartItemManager.getAll(byUserId: loggedInUserId)
        
        totalItemLbl.text = "\(cartItems.count) items"
        
//        totalPriceLabel.text = "0.00 AED"
        var totalPrice: Double = 0.0
        for cartItem in cartItems {
            let product = productManager.get(byId: cartItem.productId)!
            totalPrice += (product.price * Double(cartItem.quantity))
        }
        
        totalPriceLabel.text = "\(totalPrice) AED"
        
        
        setTableViewDesign()
        cartItemTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartItemTableView.dataSource    = self
    }
    
    func setTableViewDesign() {
        if cartItems.isEmpty {
            cartItemTableView.isHidden = true
            cartItemTableView.layer.borderWidth = 0.0
        }
        else {
            cartItemTableView.isHidden = false
            cartItemTableView.layer.borderWidth = 0.5
        }
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier) as! CartItemCell
        
        let cartItem = cartItems[indexPath.row]
        let product = productManager.get(byId: cartItem.productId)!
        
        cell.mainImgView.loadImage(url: URL(string: product.imageUrl)!)
        cell.nameLbl.text = product.name
        cell.shortDescriptionLbl.text = product.shortDescription
        cell.quantityTxtField.text = String(cartItem.quantity)
        
        
        return cell
    }
}
