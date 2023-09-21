//
//  OrderItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class OrderItem {
    let id:         Int
    let orderId:    Int
    let quantity:   Int
    let productId:  Int

    init(id: Int, orderId: Int, quantity: Int, productId: Int) {
        self.id         = id
        self.orderId    = orderId
        self.quantity   = quantity
        self.productId  = productId
    }
}
