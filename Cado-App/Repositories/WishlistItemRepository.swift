//
//  WishlistItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct WishlistItemRepository: RepositoryProtocol {
  private var wishlistItems: [WishlistItem] = []
    
    mutating func create(record: WishlistItem) {
        wishlistItems.append(record)
    }
    
    func getAll() -> [WishlistItem] {
        return wishlistItems
    }
    
    func get(byIdentifier id: Int) -> WishlistItem? {
        return wishlistItems.first { wishlistItem in
            wishlistItem.id == id
        }
    }
    
    func update(record updatedUser: WishlistItem) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = WishlistItem
    typealias Identifier = Int
}
