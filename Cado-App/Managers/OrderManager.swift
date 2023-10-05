//
//  OrderRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class OrderManager {
    private var orderRepository = OrderRepository()
    
    func create(_ order: Order) {
        orderRepository.create(record: order)
    }
    
    func getAll() -> [Order] {
        orderRepository.getAll()
    }
    
    func getAll(byUserId userId: Int) -> [Order] {
        let orderList = getAll()
        
        return orderList.filter { order in
            return order.userId == userId
        }
    }
    
    func get(byId id: Int) -> Order? {
        orderRepository.get(byIdentifier: id)
    }
    
    func update(_ order: Order) -> Bool {
        orderRepository.update(record: order)
    }
    
    func delete(byId id: Int) -> Bool {
        orderRepository.delete(byIdentifier: id)
    }
}
