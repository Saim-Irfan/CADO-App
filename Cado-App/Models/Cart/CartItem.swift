//
//  CartItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class CartItem {
    let id:         Int
    let cartId:     Int
    let productId:  Int
    let quantity:   Int

    init(id: Int, cartId: Int, productId: Int, quantity: Int) {
        self.id         = id
        self.cartId     = cartId
        self.productId  = productId
        self.quantity   = quantity
    }
}

