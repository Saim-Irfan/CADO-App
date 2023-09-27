//
//  BannerItem.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation

class BannerItem: SectionItem {
    let title: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "image_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        
        title = try! container.decode(String.self, forKey: .title)
        imageUrl = try! container.decode(String.self, forKey: .imageUrl)
        
        try! super.init(from: decoder)
    }
}
