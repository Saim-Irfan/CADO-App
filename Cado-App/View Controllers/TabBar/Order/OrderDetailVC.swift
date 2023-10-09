//
//  OrderDetailVC.swift
//  Cado-App
//
//  Created by Saim on 05/10/2023.
//

import UIKit

class OrderDetailVC: UIViewController {
    static let storyboardIdentifier = "orderDetailVC"
    
    @IBOutlet var orderDateLbl: UILabel!
    @IBOutlet var orderIdLbl: UILabel!
    @IBOutlet var orderPriceLbl: UILabel!
    
    @IBOutlet var itemsStackView: UIStackView!
    @IBOutlet var itemStackViewHeight: NSLayoutConstraint!
    
    @IBOutlet var deliveryDateLbl: UILabel!
    
    @IBOutlet var orderTotalLbl: UILabel!
    
    private let orderManager    = OrderManager()
    private let orderItemManger = OrderItemManager()
    
    private let productManager  = ProductManager()
    
    var orderId: Int!
    
    private var order: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.order = orderManager.get(byId: orderId)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        
        let formattedDate = dateFormatter.string(from: order.date)
        
        orderDateLbl.text   = formattedDate
        orderIdLbl.text     = order.id.description
        orderPriceLbl.text  = "AED \(order.totalPrice)"
        
        let orderItemList = orderItemManger.getAll(byOrderId: orderId)
        
        let orderItemHeight     = 100.0
        var mainStackViewHeight = 0.0
        
        for orderItem in orderItemList {
            let product = productManager.get(byId: orderItem.productId)!
            
            let orderItemView = OrderItemView(frame: .zero)
            orderItemView.translatesAutoresizingMaskIntoConstraints = false
            orderItemView.heightAnchor.constraint(equalToConstant: orderItemHeight).isActive = true
            
            orderItemView.configure(imgUrl: product.imageUrl, produceName: product.name, productPrice: orderItem.price, productQuantity: orderItem.quantity)
            
            itemsStackView.addArrangedSubview(orderItemView)
            
            mainStackViewHeight += orderItemHeight
        }
        
        itemStackViewHeight.constant = mainStackViewHeight
        
        
        deliveryDateLbl.text = dateFormatter.string(from: order.deliveryDate)
        
        orderTotalLbl.text = "\(order.totalPrice) AED"
    }
}
