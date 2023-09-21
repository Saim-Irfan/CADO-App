//
//  Product.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class Product {
    let id:                 Int
    let name:               String
    let description:        String
    let shortDescription:   String
    let price:              Double
    let quantity:           Int
    let shippingDays:       Int
    
    
    init(id: Int, name: String, description: String, shortDescription: String, price: Double, quantity: Int, shippingDays: Int) {
        self.id                 = id
        self.name               = name
        self.description        = description
        self.shortDescription   = shortDescription
        self.price              = price
        self.quantity           = quantity
        self.shippingDays       = shippingDays
    }
}
