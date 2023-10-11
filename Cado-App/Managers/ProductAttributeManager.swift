//
//  ProductAttribute.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class ProductAttributeManager {
    private var productAttributeRepository = ProductAttributeRepository()
    
    func create(_ productAttribute: ProductAttribute) {
        productAttributeRepository.create(record: productAttribute)
    }
    
    func getAll() -> [ProductAttribute] {
        productAttributeRepository.getAll()
    }
    
    func getAll(byProductId productId: Int) -> [ProductAttribute] {
        let productAttributeList = productAttributeRepository.getAll()
        
        return productAttributeList.filter { productAttribute in
            productAttribute.productId == productId
        }
    }
    
    func get(byId id: Int) -> ProductAttribute? {
        productAttributeRepository.get(byIdentifier: id)
    }
    
    func update(_ attribute: ProductAttribute) -> Bool {
        productAttributeRepository.update(record: attribute)
    }
    
    func delete(byId id: Int) -> Bool {
        productAttributeRepository.delete(byIdentifier: id)
    }
}
