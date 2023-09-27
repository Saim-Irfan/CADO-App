//
//  Section.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation

class Section: Decodable {
    let id: Int
    let type: SectionType
    let title: String?
    let items: [SectionItem]
    
    enum CodingKeys: CodingKey {
        case id, type, title, items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        
        id = try! container.decode(Int.self, forKey: .id)
        type = try! container.decode(SectionType.self, forKey: .type)
        title = (try? container.decode(String.self, forKey: .title)) ?? ""
        
        switch type {
        case .bigBanner, .smallBanner:
            items = try! container.decode([BannerItem].self, forKey: .items)
        case .scrollable:
            items = try! container.decode([ProductItem].self, forKey: .items)
        }
    }
    
}


enum SectionType: String, Decodable, Hashable {
    case bigBanner = "big_banner"
    case smallBanner = "small_banner"
    case scrollable = "scrollable"
}
