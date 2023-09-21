//
//  OrderItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct OrderItemRepository: RepositoryProtocol {
  private var orderItems: [OrderItem] = []
    
    mutating func create(record: OrderItem) {
        orderItems.append(record)
    }
    
    func getAll() -> [OrderItem] {
        return orderItems
    }
    
    func get(byIdentifier id: Int) -> OrderItem? {
        return orderItems.first { orderItem in
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
