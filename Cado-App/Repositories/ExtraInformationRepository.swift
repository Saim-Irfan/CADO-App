//
//  ExtraInformationRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct ExtraInformationRepository: RepositoryProtocol {
  private var extraInformationList: [ExtraInformation] = []
    
    mutating func create(record: ExtraInformation) {
        extraInformationList.append(record)
    }
    
    func getAll() -> [ExtraInformation] {
        return extraInformationList
    }
    
    func get(byIdentifier id: Int) -> ExtraInformation? {
        return extraInformationList.first { extraInformation in
            extraInformation.id == id
        }
    }
    
    func update(record updatedUser: ExtraInformation) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = ExtraInformation
    typealias Identifier = Int
}
