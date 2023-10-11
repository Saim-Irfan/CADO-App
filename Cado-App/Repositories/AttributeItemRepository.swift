//
//  AttributeItemRepository.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation

struct AttributeItemRepository: RepositoryProtocol {
  private static var attributeItems: [AttributeItem] = [
        AttributeItem(id: 1,
                      attributeId: 1,
                      value: "Small"),
        AttributeItem(id: 2,
                      attributeId: 1,
                      value: "Medium"),
        AttributeItem(id: 3,
                      attributeId: 1,
                      value: "Large"),
        
        
        AttributeItem(id: 4,
                      attributeId: 2,
                      value: "Roses"),
        AttributeItem(id: 5,
                      attributeId: 2,
                      value: "Tulips"),
        AttributeItem(id: 6,
                      attributeId: 2,
                      value: "Mixed"),
        
        AttributeItem(id: 7,
                      attributeId: 3,
                      value: "Small"),
        AttributeItem(id: 8,
                      attributeId: 3,
                      value: "Medium"),
        AttributeItem(id: 9,
                      attributeId: 3,
                      value: "Large"),
  ]
    
    mutating func create(record: AttributeItem) {
        AttributeItemRepository.attributeItems.append(record)
    }
    
    func getAll() -> [AttributeItem] {
        return AttributeItemRepository.attributeItems
    }
    
    func get(byIdentifier id: Int) -> AttributeItem? {
        return AttributeItemRepository.attributeItems.first { attributeItem in
            attributeItem.id == id
        }
    }
    
    func update(record updatedUser: AttributeItem) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = AttributeItem
    typealias Identifier = Int
}
