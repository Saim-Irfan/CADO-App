//
//  PurchaseVC.swift
//  Cado-App
//
//  Created by Saim on 04/10/2023.
//

import UIKit

class PurchaseVC: UIViewController {
    static let storyboardIdentifier = "purchaseVC"
    
    
    @IBOutlet var giftCardStackView: UIStackView!
    @IBOutlet var giftCardRadioBtn: AddressRadioButton!
    
    @IBOutlet var paymentRadioOne: AddressRadioButton!
    @IBOutlet var paymentRadioTwo: AddressRadioButton!
    
    @IBOutlet var paymentStackViewOne: UIStackView!
    @IBOutlet var paymentStackViewTwo: UIStackView!
    
    @IBOutlet var orderSummaryStackView: UIStackView!
    @IBOutlet var orderSummaryDetailHeight: NSLayoutConstraint!
    
    @IBOutlet var totalPriceLbl: UILabel!
    
    @IBOutlet var completePurchaseBtn: PrimaryButton!
    
    private let orderManager = OrderManager()
    private let orderItemManager = OrderItemManager()
    
    private let cartItemManager = CartItemManager()
    
    private let productManager = ProductManager()
    
    var totalPrice = 0.0
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Purchase"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let giftCardTapGesture = UITapGestureRecognizer(target: self, action: #selector(giftCardRadioTapped))
        giftCardStackView.addGestureRecognizer(giftCardTapGesture)
        
        let paymentStackOneGesture = UITapGestureRecognizer(target: self, action: #selector(paymentStackOneTapped))
        paymentStackViewOne.addGestureRecognizer(paymentStackOneGesture)
        
        let paymentStackTwoGesture = UITapGestureRecognizer(target: self, action: #selector(paymentStackTwoTapped))
        paymentStackViewTwo.addGestureRecognizer(paymentStackTwoGesture)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(orderSummaryStackViewTapped))
        orderSummaryStackView.isUserInteractionEnabled = true
        orderSummaryStackView.addGestureRecognizer(tapGesture)
        
        totalPriceLbl.text = "\(totalPrice) AED"
        
        completePurchaseBtn.setDisabled()
    }
    
    func createOrder() {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        
        let currentDate = Date.now
        var dateComponent = DateComponents()
        dateComponent.setValue(3, for: .day)
        let deliveryDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
        
        let newOrder = Order(userId: loggedInUserId, date: currentDate, status: .inProgress, totalPrice: totalPrice, deliveryDate: deliveryDate)
        
        orderManager.create(newOrder)
        
        let cartItemListOfUser = cartItemManager.getAll(byUserId: loggedInUserId)
        
        for cartItem in cartItemListOfUser {
            let product = productManager.get(byId: cartItem.productId)!
            
            let newOrderItem = OrderItem(orderId: newOrder.id, productId: cartItem.productId, quantity: cartItem.quantity, price: product.price)
            orderItemManager.create(newOrderItem)
        }
    }
    
    func updateProductsQuantities() {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        let cartItemListOfUser = cartItemManager.getAll(byUserId: loggedInUserId)
        
        for cartItem in cartItemListOfUser {
            let product = productManager.get(byId: cartItem.productId)!
            productManager.updateQuantity(of: product.id, to: product.quantity - cartItem.quantity)
        }
    }
    
    
    func removeItemsFromCart() {
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        cartItemManager.emptyCart(of: loggedInUserId)
    }
    
    @objc func orderSummaryStackViewTapped() {
        if orderSummaryDetailHeight.constant == 0.0 {
            orderSummaryDetailHeight.constant = 44.0
        }
        else {
            orderSummaryDetailHeight.constant = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    

    
    @objc func giftCardRadioTapped() {
        if giftCardRadioBtn.isChosen {
            giftCardRadioBtn.setAsDisabled()
        }
        else {
            giftCardRadioBtn.setAsEnabled()
        }
    }
    
    
    @objc func paymentStackOneTapped() {
        paymentRadioTwo.setAsDisabled()
        paymentRadioOne.setAsEnabled()
        completePurchaseBtn.setEnabled()
    }
    
    @objc func paymentStackTwoTapped() {
        paymentRadioOne.setAsDisabled()
        paymentRadioTwo.setAsEnabled()
        completePurchaseBtn.setEnabled()
    }
    
    @IBAction func purchaseBtnTapped(_ sender: PrimaryButton) {
        createOrder()
        updateProductsQuantities()
        removeItemsFromCart()
        
        guard let mainTabBarVC = navigationController?.viewControllers.first(where: { viewController in
            viewController is UITabBarController
        }) as? UITabBarController else {
            return
        }
        
        mainTabBarVC.selectedIndex = HomeVC.tabbarIndex
        
        let confirmationVC = storyboard?.instantiateViewController(withIdentifier: ConfirmationVC.storyboardIdentifier) as! ConfirmationVC
        
        let viewControllerList = [mainTabBarVC, confirmationVC]
        
        navigationController?.setViewControllers(viewControllerList, animated: true)
    }
}
