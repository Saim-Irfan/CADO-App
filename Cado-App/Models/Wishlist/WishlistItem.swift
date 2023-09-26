//
//  WishlistItem.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//


import Foundation

class WishlistItem {
    let id:         Int
    let userId:     Int
    let productId:  Int

    init(id: Int, userId: Int, productId: Int) {
        self.id         = id
        self.userId     = userId
        self.productId  = productId
    }
}

