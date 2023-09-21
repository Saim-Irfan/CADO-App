//
//  CartItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class CartItemManager {
    private var cartItemRepository = CartItemRepository()
    
    func create(_ cartItem: CartItem) {
        cartItemRepository.create(record: cartItem)
    }
    
    func getAll() -> [CartItem] {
        cartItemRepository.getAll()
    }
    
    func get(byId id: Int) -> CartItem? {
        cartItemRepository.get(byIdentifier: id)
    }
    
    func update(_ cartItem: CartItem) -> Bool {
        cartItemRepository.update(record: cartItem)
    }
    
    func delete(byId id: Int) -> Bool {
        cartItemRepository.delete(byIdentifier: id)
    }
}
