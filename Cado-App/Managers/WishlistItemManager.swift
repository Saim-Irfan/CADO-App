//
//  WishlistItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class WishlistItemManager {
    private var wishlistItemRepository = WishlistItemRepository()
    
    func create(_ wishlistItem: WishlistItem) {
        wishlistItemRepository.create(record: wishlistItem)
    }
    
    func getAll() -> [WishlistItem] {
        wishlistItemRepository.getAll()
    }
    
    func getAll(byUserId userId: Int) -> [WishlistItem] {
        let wishlistItemList = getAll()
        
        return wishlistItemList.filter { wishlistItem in
            return wishlistItem.userId == userId
        }
    }
    
    func get(byId id: Int) -> WishlistItem? {
        wishlistItemRepository.get(byIdentifier: id)
    }
    
    func update(_ wishlistItem: WishlistItem) -> Bool {
        wishlistItemRepository.update(record: wishlistItem)
    }
    
    func delete(byId id: Int) -> Bool {
        wishlistItemRepository.delete(byIdentifier: id)
    }
    
    func remove(productId: Int, for userId: Int) {
        let wishlistItemList = getAll(byUserId: userId)
        
        guard let wishlistItem = wishlistItemList.first(where: { wishlistItem in
            wishlistItem.productId == productId
        }) else {
            return
        }
        
        delete(byId: wishlistItem.id)
    }
    
    func checkIfExists(productId: Int,for userId: Int) -> Bool {
        let wishlistItemList = getAll(byUserId: userId)
        
        return wishlistItemList.contains { wishlistItem in
            wishlistItem.productId == productId
        }
    }
}
