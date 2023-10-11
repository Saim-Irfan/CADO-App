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
                name: "Mirzam Wooden Tray",
                imageUrl: "https://mirzam.com/wp-content/uploads/mirzam-ramadan-mar22-e0006-3.jpg",
                secondaryImgUrlList: [],
                description: """
                "A customized luxurious wooden walnut box with acrylic cover specially made for Mirzam Chocolates .
                It’s Intricate pattern and antique finish accessories makes it an exquisite gift.
                Our delicious dark chocolate dates are made using our dreamy bean to bar, vegan 62% and 100% dark chocolate, thick coating locally grown delicious Khalas dates; together with natural spices, nuts, and fruits.
                """,
                shortDescription: "Mirzam Wooden Tray: Assorted Dates",
                price: 447,
                quantity: 10,
                shippingDays: 3),
        
        Product(id: 2,
                name: "Mother's Day Bouqet",
                imageUrl: "https://thumbs.dreamstime.com/b/rose-flowers-bouquet-isolated-27274345.jpg",
                secondaryImgUrlList: [
                    "https://images.unsplash.com/photo-1523693916903-027d144a2b7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Ym91cXVldHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
                    "https://media.gettyimages.com/id/661799917/photo/hand-holding-bouquet-of-flowers.jpg?s=612x612&w=gi&k=20&c=_vqav9HDBJYLciCtGqu44TDlnFPtwAqlqZPXHPqaudE="
                ],
                description: "Gift your mother a lovely gift",
                shortDescription: "A Bouqet of Flowers",
                price: 10,
                quantity: 50,
                shippingDays: 1),
        Product(id: 3,
                name: "Parker Jotter Pen",
                imageUrl: "https://cdn.shopify.com/s/files/1/0740/3477/4328/files/956f-4e-st42-6gs04a14.jpg?v=1694171086&width=900",
                secondaryImgUrlList: [
                    "https://s7d9.scene7.com/is/image//NewellRubbermaid/1953184_jttr_imgps_20-1",
                    "https://s7d9.scene7.com/is/image//NewellRubbermaid/1953187_jttr_imgps_20-1"
                ],
                description: """
                Glossy Coloured Plastic finish with a retro touch inspires original ideas.
                The iconic jotter design.
                Ultra resistant plastic body.
                Signature retractable design opens and closes with a satisfying click.
                Fitted with Quinkflow ballpoint refill for optimal ink flow",
                shortDescription: "A Bouqet of Flowers
                """,
                shortDescription: "Parker Jotter Originals Chrome Trim Ball Pen",
                price: 375,
                quantity: 100,
                shippingDays: 1),
        Product(id: 4,
                name: "Istanbul Wallet",
                imageUrl: "https://jafferjees.com/pub/media/catalog/product/cache/afe89fe21145501a9d33deb753d77fcd/1/1/1153190101_1_1.jpg",
                secondaryImgUrlList: [],
                description: """
                Just like the city from which it draws its name, this wallet is traditional in appearance despite its sleek and modern design.
                """,
                shortDescription: "Men's Wallet",
                price: 15,
                quantity: 25,
                shippingDays: 1),
        Product(id: 5,
                name: "BOLD Handbag",
                imageUrl: "https://sistabag.com/cdn/shop/files/W1_1.jpg?v=1690222042&width=990",
                secondaryImgUrlList: [],
                description: """
                Introducing Sistabag‘s Saddle Bag - where style meets empowerment. Our Saddle Bag celebrate the spirit of Black women with diverse design themes and inspirational quotes. Carry your pride, embrace your beauty, and make a powerful statement with Sistabag.
                
                Product Details:
                Made of high-quality canvas for durability and scratch resistance.
                Features an adjustable shoulder strap allows you to customize the length.
                Your belongings stay secure with magnetic closure outside.
                Stay organized with 1 back slip pocket and an inner compartment/zipper closer for easily accessible items.
                Personalize your saddle bag with your name, free of charge.
                
                Embrace elegance, empowerment, and self-expression with Sistabag’s Saddle Bag. Shop now and carry a piece of your identity with you wherever you go.
                """,
                shortDescription: "I am BOLD, LOVED, STRONG, RESILIENT - Personalized Leather Handbag STB49A",
                price: 12000,
                quantity: 100,
                shippingDays: 1)
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
