//
//  ProductItem.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation

class ProductItem: SectionItem {
    let productIdList: [Int]
    
    enum CodingKeys: String, CodingKey {
        case productIdList = "product_id_list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        productIdList = try! container.decode([Int].self, forKey: .productIdList)
        
        try! super.init(from: decoder)
    }
}
