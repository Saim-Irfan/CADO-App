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
    
    private let productManager = ProductManager()
    private let cartItemManager = CartItemManager()
    
    private var cartItems: [CartItem] = []
    
    override func viewDidAppear(_ animated: Bool) {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.cartItems = cartItemManager.getAll(byUserId: loggedInUserId)
        
        totalItemLbl.text = "\(cartItems.count) items"
        
        cartItemTableView.reloadData()
        setTableViewBorder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartItemTableView.dataSource    = self
    }
    
    func setTableViewBorder() {
        if cartItems.isEmpty {
            cartItemTableView.layer.borderWidth = 0.0
        }
        else {
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
