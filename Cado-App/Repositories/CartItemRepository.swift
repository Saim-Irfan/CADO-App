//
//  CartItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct CartItemRepository: RepositoryProtocol {
  private static var cartItems: [CartItem] = [
        CartItem(userId: 1,
                 productId: 1,
                 quantity: 5)
  ]
    
    mutating func create(record: CartItem) {
        CartItemRepository.cartItems.append(record)
    }
    
    func getAll() -> [CartItem] {
        return CartItemRepository.cartItems
    }
    
    func get(byIdentifier id: Int) -> CartItem? {
        return CartItemRepository.cartItems.first { cartItem in
            cartItem.id == id
        }
    }
    
    func update(record updatedUser: CartItem) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        CartItemRepository.cartItems.removeAll { cartItem in
            cartItem.id == id
        }
        
        return true
    }
    
    typealias Record = CartItem
    typealias Identifier = Int
}
