//
//  CartItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct CartItemRepository: RepositoryProtocol {
  private var cartItems: [CartItem] = []
    
    mutating func create(record: CartItem) {
        cartItems.append(record)
    }
    
    func getAll() -> [CartItem] {
        return cartItems
    }
    
    func get(byIdentifier id: Int) -> CartItem? {
        return cartItems.first { cartItem in
            cartItem.id == id
        }
    }
    
    func update(record updatedUser: CartItem) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = CartItem
    typealias Identifier = Int
}
