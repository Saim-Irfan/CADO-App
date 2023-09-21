//
//  ProductRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class ProductManager {
    private var productRepository = ProductRepository()
    
    func create(_ product: Product) {
        productRepository.create(record: product)
    }
    
    func getAll() -> [Product] {
        productRepository.getAll()
    }
    
    func get(byId id: Int) -> Product? {
        productRepository.get(byIdentifier: id)
    }
    
    func update(_ product: Product) -> Bool {
        productRepository.update(record: product)
    }
    
    func delete(byId id: Int) -> Bool {
        productRepository.delete(byIdentifier: id)
    }
}
