//
//  OrderRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct OrderRepository: RepositoryProtocol {
  private static var orders: [Order] = []
    
    mutating func create(record: Order) {
        OrderRepository.orders.append(record)
    }
    
    func getAll() -> [Order] {
        return OrderRepository.orders
    }
    
    func get(byIdentifier id: Int) -> Order? {
        return OrderRepository.orders.first { order in
            order.id == id
        }
    }
    
    func update(record updatedUser: Order) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = Order
    typealias Identifier = Int
}
