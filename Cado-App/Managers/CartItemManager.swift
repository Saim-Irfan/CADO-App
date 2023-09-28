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
    
    func getAll(byUserId userId: Int) -> [CartItem] {
        let cartItems = getAll()
        
        return cartItems.filter { cartItem in
            return cartItem.userId == userId
        }
    }
    
    func update(_ cartItem: CartItem) -> Bool {
        cartItemRepository.update(record: cartItem)
    }
    
    func delete(byId id: Int) -> Bool {
        cartItemRepository.delete(byIdentifier: id)
    }
    
    func returnCartItemId(for userId: Int, productId: Int) -> Int? {
        let items = getAll(byUserId: userId)
        
        guard let itemIndex = items.firstIndex (where: { cartItem in
            cartItem.productId == productId
        }) else {
            return nil
        }
        
        let cartItemId = items[itemIndex].id
        
        return cartItemId
    }
    
    func addToCart(userId: Int, productId: Int, quantity: Int) {
        guard let cartItemId = returnCartItemId(for: userId, productId: productId) else {
            let newCartItem = CartItem(userId: userId, productId: productId, quantity: quantity)
            create(newCartItem)
            return
        }
        
        let cartItem = get(byId: cartItemId)!
        
        cartItem.quantity += quantity
    }
}
