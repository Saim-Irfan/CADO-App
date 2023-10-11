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
    
    func getInStockAvailable() -> [Product] {
        let productList = getAll()
        var availableProductList = [Product]()
        
        for product in productList {
            if product.quantity > 0 {
                availableProductList.append(product)
            }
        }
        
        return availableProductList
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
    
    func updateQuantity(of productId: Int, to value: Int) {
        let product = get(byId: productId)!
        
        let updatedProduct = Product(id: productId, name: product.name, imageUrl: product.imageUrl, secondaryImgUrlList: product.secondaryImgUrlList, description: product.description, shortDescription: product.shortDescription, price: product.price, quantity: value, shippingDays: product.shippingDays)
        
        update(updatedProduct)
    }
}
