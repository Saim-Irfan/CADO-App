//
//  OrderItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct OrderItemRepository: RepositoryProtocol {
  private static var orderItems: [OrderItem] = [
        OrderItem(orderId: 1,
                  productId: 1,
                  quantity: 10,
                  price: 10.0),
        OrderItem(orderId: 2,
                  productId: 1,
                  quantity: 5,
                  price: 10.0),
        OrderItem(orderId: 2,
                  productId: 1,
                  quantity: 5,
                  price: 10.0)
  ]
    
    mutating func create(record: OrderItem) {
        OrderItemRepository.orderItems.append(record)
    }
    
    func getAll() -> [OrderItem] {
        return OrderItemRepository.orderItems
    }
    
    func get(byIdentifier id: Int) -> OrderItem? {
        return OrderItemRepository.orderItems.first { orderItem in
            orderItem.id == id
        }
    }
    
    func update(record updatedUser: OrderItem) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = OrderItem
    typealias Identifier = Int
}
