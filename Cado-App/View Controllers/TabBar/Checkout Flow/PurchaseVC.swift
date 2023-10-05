//
//  PurchaseVC.swift
//  Cado-App
//
//  Created by Saim on 04/10/2023.
//

import UIKit

class PurchaseVC: UIViewController {
    static let storyboardIdentifier = "purchaseVC"
    
    
    @IBOutlet var paymentRadioOne: AddressRadioButton!
    @IBOutlet var paymentRadioTwo: AddressRadioButton!
    
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

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(orderSummaryStackViewTapped))
        
        orderSummaryStackView.isUserInteractionEnabled = true
        orderSummaryStackView.addGestureRecognizer(tapGesture)
        
        totalPriceLbl.text = "\(totalPrice) AED"
        
        completePurchaseBtn.setDisabled()
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
    

    
    @IBAction func giftCardRadioTapped(_ sender: AddressRadioButton) {
        if sender.isChosen {
            sender.setAsDisabled()
        }
        else {
            sender.setAsEnabled()
        }
    }
    
    
    @IBAction func paymentRadioOneTapped(_ sender: AddressRadioButton) {
        paymentRadioTwo.setAsDisabled()
        paymentRadioOne.setAsEnabled()
        completePurchaseBtn.setEnabled()
    }
    
    @IBAction func paymentRadioTwoTapped(_ sender: AddressRadioButton) {
        paymentRadioOne.setAsDisabled()
        paymentRadioTwo.setAsEnabled()
        completePurchaseBtn.setEnabled()
    }
    
    @IBAction func purchaseBtnTapped(_ sender: PrimaryButton) {
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
}
