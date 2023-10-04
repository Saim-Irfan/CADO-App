//
//  RecipientAddressRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class RecipientAddressManager {
    private var recipientAddressRepository = RecipientAddressRepository()
    
    func create(_ recipientAddress: RecipientAddress) {
        recipientAddressRepository.create(record: recipientAddress)
    }
    
    func getAll() -> [RecipientAddress] {
        recipientAddressRepository.getAll()
    }
    
    func getAll(byUserId userId: Int) -> [RecipientAddress] {
        let recipientAddressList = getAll()
        
        return recipientAddressList.filter { recipientAddress in
            return recipientAddress.userId == userId
        }
    }
    
    func get(byId id: Int) -> RecipientAddress? {
        recipientAddressRepository.get(byIdentifier: id)
    }
    
    func update(_ recipientAddress: RecipientAddress) -> Bool {
        recipientAddressRepository.update(record: recipientAddress)
    }
    
    func delete(byId id: Int) -> Bool {
        recipientAddressRepository.delete(byIdentifier: id)
    }
}
