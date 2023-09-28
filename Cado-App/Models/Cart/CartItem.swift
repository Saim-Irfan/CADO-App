//
//  CartItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class CartItem {
    private static var availableCartItemId = 1
    
    let id:         Int
    let userId:     Int
    let productId:  Int
    var quantity:   Int

    init(userId: Int, productId: Int, quantity: Int) {
        self.id         = CartItem.availableCartItemId
        self.userId     = userId
        self.productId  = productId
        self.quantity   = quantity
        
        CartItem.availableCartItemId += 1
    }
}

