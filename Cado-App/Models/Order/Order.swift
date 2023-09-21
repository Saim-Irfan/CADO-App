//
//  Order.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class Order {
    let id:           Int
    let userId:       Int
    let date:         Date
    let status:       String
    let totalPrice:   Double
    let deliveryDate: Date

    init(id: Int, userId: Int, date: Date, status: String, totalPrice: Double, deliveryDate: Date) {
        self.id           = id
        self.userId       = userId
        self.date         = date
        self.status       = status
        self.totalPrice   = totalPrice
        self.deliveryDate = deliveryDate
    }
}
