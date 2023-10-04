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
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var proceedToCheckoutBtn: PrimaryButton!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    private let productManager = ProductManager()
    private let cartItemManager = CartItemManager()
    
    private var cartItems: [CartItem] = []
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Cart"
        
        configureScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        cartItemTableView.dataSource    = self
    }
    
    func configureScreen() {
        configureCart()
        setTotalPrice()
                
        setTableViewDesign()
        cartItemTableView.reloadData()
    }
    
    func setTableViewDesign() {
        if cartItems.isEmpty {
            tableViewHeightConstraint.constant = 0.0
            cartItemTableView.isHidden = true
            cartItemTableView.layer.borderWidth = 0.0
            proceedToCheckoutBtn.setDisabled()
        }
        else {
            if cartItems.count < 2 {
                tableViewHeightConstraint.constant = 150.0
            }
            else {
                tableViewHeightConstraint.constant = 350.0
            }
            
            cartItemTableView.isHidden = false
            cartItemTableView.layer.borderWidth = 0.5
            proceedToCheckoutBtn.setEnabled()
        }
    }
    
    func configureCart() {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.cartItems = cartItemManager.getAll(byUserId: loggedInUserId)
    }
    
    func setTotalPrice() {
        totalItemLbl.text = "\(cartItems.count) items"
        
        var totalPrice: Double = 0.0
        for cartItem in cartItems {
            let product = productManager.get(byId: cartItem.productId)!
            totalPrice += (product.price * Double(cartItem.quantity))
        }
        
        totalPriceLabel.text = "\(totalPrice) AED"
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
        
        cell.cartItemId = cartItem.id
        cell.deleteBtnCallback = { cartItemId in
            self.cartItemManager.delete(byId: cartItemId)
            self.configureScreen()
        }
        
        
        return cell
    }
}
