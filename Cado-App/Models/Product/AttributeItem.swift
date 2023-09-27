//
//  AttributeItem.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//


class AttributeItem {
    let id:             Int
    let attributeId:    Int
    let value:          String
    
    init(id: Int, attributeId: Int, value: String) {
        self.id             = id
        self.attributeId    = attributeId
        self.value          = value
    }
}
