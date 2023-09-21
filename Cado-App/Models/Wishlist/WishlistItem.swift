//
//  WishlistItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//


import Foundation

class WishlistItem {
    let id:         Int
    let wishlistId: Int
    let productId:  Int

    init(id: Int, wishlistId: Int, productId: Int) {
        self.id         = id
        self.wishlistId = wishlistId
        self.productId  = productId
    }
}

