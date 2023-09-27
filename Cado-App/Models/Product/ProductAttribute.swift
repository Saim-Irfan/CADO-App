//
//  ProductAttribute.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class ProductAttribute {
    let id:         Int
    let productId:   Int
    let name:       String
    
    
    init(id: Int, productId: Int, name: String) {
        self.id             = id
        self.productId      = productId
        self.name           = name
    }
}
