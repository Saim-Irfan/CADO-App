//
//  RecipientAddressRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct RecipientAddressRepository: RepositoryProtocol {
  private static var addresses: [RecipientAddress] = [
        RecipientAddress(id:            1,
                         userId:        1,
                         firstName:     "Moiz",
                         lastName:      "Ali",
                         mobileNumber:  "03102573772",
                         street:        "234 Sheikh Zayed Street",
                         residence:     "Sheikh Zayed Residence",
                         city:          "Abu Dhabi",
                         instruction:   ""),
        
        RecipientAddress(id:            2,
                         userId:        1,
                         firstName:     "Inshal",
                         lastName:      "Ayaz",
                         mobileNumber:  "03102573772",
                         street:        "234 Sheikh Zayed Street",
                         residence:     "Sheikh Zayed Residence",
                         city:          "Abu Dhabi",
                         instruction:   "Place on the stairs"),
  ]
    
    mutating func create(record: RecipientAddress) {
        RecipientAddressRepository.addresses.append(record)
    }
    
    func getAll() -> [RecipientAddress] {
        return RecipientAddressRepository.addresses
    }
    
    func get(byIdentifier id: Int) -> RecipientAddress? {
        return RecipientAddressRepository.addresses.first { address in
            address.id == id
        }
    }
    
    func update(record updatedUser: RecipientAddress) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        return true
    }
    
    typealias Record = RecipientAddress
    typealias Identifier = Int
}
