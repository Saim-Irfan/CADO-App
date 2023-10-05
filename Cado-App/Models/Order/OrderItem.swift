//
//  OrderItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class OrderItem {
    private static var availableOrderItemId = 1
    
    let id:         Int
    let orderId:    Int
    let productId:  Int
    let quantity:   Int
    let price:      Double

    init(orderId: Int, productId: Int, quantity: Int, price: Double) {
        self.id         = OrderItem.availableOrderItemId
        self.orderId    = orderId
        self.productId  = productId
        self.quantity   = quantity
        self.price      = price
        
        OrderItem.availableOrderItemId += 1
    }
}
