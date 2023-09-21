//
//  ExtraInformation.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class ExtraInformation {
    let id:             Int
    let productId:      Int
    let name:           String
    let description:    String

    init(id: Int, productId: Int, name: String, description: String) {
        self.id             = id
        self.productId      = productId
        self.name           = name
        self.description    = description
    }
}
