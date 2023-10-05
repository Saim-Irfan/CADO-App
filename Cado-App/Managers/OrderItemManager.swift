//
//  OrderItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class OrderItemManager {
    private var orderItemRepository = OrderItemRepository()
    
    func create(_ orderItem: OrderItem) {
        orderItemRepository.create(record: orderItem)
    }
    
    func getAll() -> [OrderItem] {
        orderItemRepository.getAll()
    }
    
    func getAll(byOrderId orderId: Int) -> [OrderItem] {
        let orderItemList = getAll()
        
        return orderItemList.filter { orderItem in
            return orderItem.orderId == orderId
        }
    }
    
    func get(byId id: Int) -> OrderItem? {
        orderItemRepository.get(byIdentifier: id)
    }
    
    func update(_ orderItem: OrderItem) -> Bool {
        orderItemRepository.update(record: orderItem)
    }
    
    func delete(byId id: Int) -> Bool {
        orderItemRepository.delete(byIdentifier: id)
    }
}
