//
//  WishlistItemRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct WishlistItemRepository: RepositoryProtocol {
  private static var wishlistItems: [WishlistItem] = []
    
    mutating func create(record: WishlistItem) {
        WishlistItemRepository.wishlistItems.append(record)
    }
    
    func getAll() -> [WishlistItem] {
        return WishlistItemRepository.wishlistItems
    }
    
    func get(byIdentifier id: Int) -> WishlistItem? {
        return WishlistItemRepository.wishlistItems.first { wishlistItem in
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
