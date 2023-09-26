//
//  ProductRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct ProductRepository: RepositoryProtocol {
  private static var products: [Product] = []
    
    mutating func create(record: Product) {
        ProductRepository.products.append(record)
    }
    
    func getAll() -> [Product] {
        return ProductRepository.products
    }
    
    func get(byIdentifier id: Int) -> Product? {
        return ProductRepository.products.first { product in
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
