//
//  ProductRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct ProductRepository: RepositoryProtocol {
  private var products: [Product] = []
    
    mutating func create(record: Product) {
        products.append(record)
    }
    
    func getAll() -> [Product] {
        return products
    }
    
    func get(byIdentifier id: Int) -> Product? {
        return products.first { product in
            product.id == id
        }
    }
    
    func update(record updatedUser: Product) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = Product
    typealias Identifier = Int
}
