//
//  AttributeItemManager.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation

class AttributeItemManager {
    private var attributeItemRepository = AttributeItemRepository()
    
    func create(_ productAttribute: AttributeItem) {
        attributeItemRepository.create(record: productAttribute)
    }
    
    func getAll() -> [AttributeItem] {
        attributeItemRepository.getAll()
    }
    
    func get(byId id: Int) -> AttributeItem? {
        attributeItemRepository.get(byIdentifier: id)
    }
    
    func update(_ attribute: AttributeItem) -> Bool {
        attributeItemRepository.update(record: attribute)
    }
    
    func delete(byId id: Int) -> Bool {
        attributeItemRepository.delete(byIdentifier: id)
    }
}
