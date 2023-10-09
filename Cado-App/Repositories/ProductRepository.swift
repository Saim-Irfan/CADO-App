//
//  ProductRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct ProductRepository: RepositoryProtocol {
    private static var products: [Product] = [
        Product(id: 1,
                name: "Mirzam",
                imageUrl: "https://www.theluxediary.com/wp-content/uploads/2018/05/SmallDatesBox-e1525267997869.jpg",
                description: "This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :). This is a good choclate. Please Enjoy :).",
                shortDescription: "Dark Choclates Date",
                price: 52,
                quantity: 10,
                shippingDays: 3),
        
        Product(id: 2,
                name: "Mother's Day Bouqet",
                imageUrl: "https://thumbs.dreamstime.com/b/rose-flowers-bouquet-isolated-27274345.jpg",
                description: "Gift your mother a lovely gift",
                shortDescription: "A Bouqet of Flowers",
                price: 10,
                quantity: 50,
                shippingDays: 1),
    ]
    
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
    
    func update(record updatedProduct: Product) -> Bool {
        guard let updatedProductIndex = ProductRepository.products.firstIndex(where: { product in
            product.id == updatedProduct.id
        }) else {
            return false
        }
        
        ProductRepository.products[updatedProductIndex] = updatedProduct
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = Product
    typealias Identifier = Int
}
