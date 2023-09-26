//
//  ProductAttribute.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct ProductAttributeRepository: RepositoryProtocol {
  private static var productAttributes: [ProductAttribute] = []
    
    mutating func create(record: ProductAttribute) {
        ProductAttributeRepository.productAttributes.append(record)
    }
    
    func getAll() -> [ProductAttribute] {
        return ProductAttributeRepository.productAttributes
    }
    
    func get(byIdentifier id: Int) -> ProductAttribute? {
        return ProductAttributeRepository.productAttributes.first { productAttribute in
            productAttribute.id == id
        }
    }
    
    func update(record updatedUser: ProductAttribute) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = ProductAttribute
    typealias Identifier = Int
}
