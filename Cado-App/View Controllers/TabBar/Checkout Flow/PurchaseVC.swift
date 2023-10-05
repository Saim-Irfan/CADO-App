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
}
