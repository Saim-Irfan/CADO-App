//
//  CheckoutVC.swift
//  Cado-App
//
//  Created by Saim on 04/10/2023.
//

import UIKit

class CheckoutVC: UIViewController {
    static let storyboardIdentifier = "checkoutVC"
    
    @IBOutlet var addressStackView: UIStackView!
    @IBOutlet var addressStackViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet var orderSummaryStackView: UIStackView!
    @IBOutlet var orderSummaryDetailStackView: UIStackView!
    @IBOutlet var orderSummaryDetailStackViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet var totalPriceLbl: UILabel!
    
    private let addressManager = RecipientAddressManager()
    
    private var recipientAddressList: [RecipientAddress] = []
    private var selectedAddressIndex: Int?
    
    var totalPrice = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.recipientAddressList = addressManager.getAll(byUserId: loggedInUserId)
        
        let stackItemHeight = 80.0
        var mainStackViewHeight = 0.0
        
        if recipientAddressList.isEmpty {
            let label = UILabel.init(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            label.text = "You have not added any address!"
            label.textColor = .systemRed
            
            addressStackView.addArrangedSubview(label)
            
            mainStackViewHeight += 44.0
        }
        
        for index in 0..<recipientAddressList.count {
            let addressView = RecipientAddressView.init(frame: .zero)
            addressView.translatesAutoresizingMaskIntoConstraints = false
            addressView.heightAnchor.constraint(equalToConstant: stackItemHeight).isActive = true
            
            addressView.addressIndex = index
            addressView.mainAddressLbl.text = recipientAddressList[index].residence
            addressView.secondaryAddressLbl.text = recipientAddressList[index].city
            
            addressView.radioButtonCallback = { addressIndex in
                
                for addressView in self.addressStackView.arrangedSubviews {
                    (addressView as! RecipientAddressView).radioBtn.setAsDisabled()
                }
                
                self.selectedAddressIndex = addressIndex
                addressView.radioBtn.setAsEnabled()
            }
            
            addressStackView.addArrangedSubview(addressView)
        
            mainStackViewHeight += stackItemHeight
        }
        
        addressStackViewHeight.constant = mainStackViewHeight
        
        
        orderSummaryStackView.isUserInteractionEnabled = true
        let orderSummaryTapped = UITapGestureRecognizer(target: self, action: #selector(toggleSummaryDropDown))
        
        orderSummaryStackView.addGestureRecognizer(orderSummaryTapped)
        
        totalPriceLbl.text = "\(totalPrice) AED"
    }
    
    @objc func toggleSummaryDropDown() {
        if (orderSummaryDetailStackView.isHidden) {
            
            self.orderSummaryDetailStackView.isHidden = false
            orderSummaryDetailStackViewHeight.constant = 44.0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.orderSummaryDetailStackView.layoutIfNeeded()
            }, completion: nil)
        }
        else {
            orderSummaryDetailStackView.isHidden = true
            orderSummaryDetailStackViewHeight.constant = 0.0
        }
    }
    
    
    @IBAction func proceedToPurchaseBtnTapped(_ sender: UIButton) {
    }
    
}
