//
//  ProductAttribute.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class ProductAttribute {
    let id:         Int
    let name:       String
    let value:      Int
    let quantity:   Int

    init(id: Int, name: String, value: Int, quantity: Int) {
        self.id         = id
        self.name       = name
        self.value      = value
        self.quantity   = quantity
    }
}
