//
//  WishlistItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//


import Foundation

class WishlistItem {
    private static var availableWishListitemId = 1
    
    let id:         Int
    let userId:     Int
    let productId:  Int

    init(userId: Int, productId: Int) {
        self.id         = WishlistItem.availableWishListitemId
        self.userId     = userId
        self.productId  = productId
        
        WishlistItem.availableWishListitemId += 1
    }
}

