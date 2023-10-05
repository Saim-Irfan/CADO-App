//
//  Order.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class Order {
    private static var availableOrderId = 1
    
    let id:           Int
    let userId:       Int
    let date:         Date
    let status:       OrderStatus
    let totalPrice:   Double
    let deliveryDate: Date

    init(userId: Int, date: Date, status: OrderStatus, totalPrice: Double, deliveryDate: Date) {
        self.id           = Order.availableOrderId
        self.userId       = userId
        self.date         = date
        self.status       = status
        self.totalPrice   = totalPrice
        self.deliveryDate = deliveryDate
        
        Order.availableOrderId += 1
    }
}

enum OrderStatus: String {
    case inProgress     = "In Progress"
    case hold           = "On Hold"
    case delivered      = "Delivered"
}
