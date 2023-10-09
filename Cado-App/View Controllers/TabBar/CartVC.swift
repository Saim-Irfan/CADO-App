//
//  CartVC.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class CartVC: UIViewController {
    static let storyboardIdentifier = "cartVC"
    static let tabbarIndex = 2
    
    @IBOutlet var totalItemLbl: UILabel!
    @IBOutlet var cartItemTableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var giftWrapYesBtn: PrimaryButton!
    @IBOutlet var giftWrapNoBtn: PrimaryButton!
    
    @IBOutlet var proceedToCheckoutBtn: PrimaryButton!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    private let productManager = ProductManager()
    private let cartItemManager = CartItemManager()
    
    private var cartItems: [CartItem] = []
    
    private var totalPrice = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Cart"
        
        configureScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        giftWrapNoBtn.backgroundColor = .white
        cartItemTableView.dataSource    = self
        cartItemTableView.delegate      = self
    }
    
    func configureScreen() {
        configureCart()
        setTotalPrice()
        cartItemTableView.reloadData()
        
        setTableViewDesign()
    }
    
    func setTableViewDesign() {
        if cartItems.isEmpty {
            tableViewHeightConstraint.constant = 0.0
            cartItemTableView.isHidden = true
            cartItemTableView.layer.borderWidth = 0.0
            proceedToCheckoutBtn.setDisabled()
        }
        else {
            
            let rowHeight = cartItemTableView.delegate!.tableView!(cartItemTableView, heightForRowAt: IndexPath(row: 0, section: 0))
            
            tableViewHeightConstraint.constant = rowHeight * CGFloat(cartItems.count)
                        
            cartItemTableView.isHidden = false
            
            proceedToCheckoutBtn.setEnabled()
        }
    }
    
    func configureCart() {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.cartItems = cartItemManager.getAll(byUserId: loggedInUserId)
    }
    
    func setTotalPrice() {
        totalItemLbl.text = "\(cartItems.count) items"
        
        self.totalPrice = 0.0
        
        for cartItem in cartItems {
            let product = productManager.get(byId: cartItem.productId)!
            self.totalPrice += (product.price * Double(cartItem.quantity))
        }
        
        totalPriceLabel.text = "\(self.totalPrice) AED"
    }
    
    @IBAction func giftWrapYesBtnTapped(_ sender: Any) {
        giftWrapYesBtn.backgroundColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
        giftWrapNoBtn.backgroundColor = .white
    }
    
    @IBAction func giftWrapNoBtnTapped(_ sender: Any) {
        giftWrapNoBtn.backgroundColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
        giftWrapYesBtn.backgroundColor = .white
    }
    
    @IBAction func proceedToCheckoutBtnTapped(_ sender: Any) {
        let checkoutVC = storyboard?.instantiateViewController(withIdentifier: CheckoutVC.storyboardIdentifier) as! CheckoutVC
        
        checkoutVC.totalPrice = self.totalPrice
        
        navigationController?.pushViewController(checkoutVC, animated: true)
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
        
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        
        cell.decreaseBtnCallback = { cartItemId in
            self.cartItemManager.decreaseFromCart(userId: loggedInUserId, productId: product.id, quantity: 1)
            self.configureScreen()
        }
        
        cell.addBtnCallback = { cartItemId in
            self.cartItemManager.addToCart(userId: loggedInUserId, productId: product.id, quantity: 1)
            self.configureScreen()
        }
    
        cell.deleteBtnCallback = { cartItemId in
            self.cartItemManager.delete(byId: cartItemId)
            self.configureScreen()
        }
        
        return cell
    }
}

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartItem = cartItems[indexPath.row]
        
        let productDetailVC = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.storyboardIdentifier) as! ProductDetailVC
        productDetailVC.productId = cartItem.productId
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
}
