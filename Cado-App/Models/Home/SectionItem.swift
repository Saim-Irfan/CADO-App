//
//  SectionItem.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation

class SectionItem: Decodable, Hashable {
    let id: Int
    
    enum CodingKeys: CodingKey {
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        id = try! container.decode(Int.self, forKey: .id)
    }
    
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

