//
//  RecipientAddress.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class RecipientAddress {
    private static var availableRecipientAddressId = 1
    
    let id:           Int
    let userId:       Int
    let firstName:    String
    let lastName:     String
    let mobileNumber: String
    let street:       String
    let residence:    String
    let city:         String
    let instruction:  String

    init(userId: Int, firstName: String, lastName: String, mobileNumber: String, street: String, residence: String, city: String, instruction: String) {
        self.id           = RecipientAddress.availableRecipientAddressId
        self.userId       = userId
        self.firstName    = firstName
        self.lastName     = lastName
        self.mobileNumber = mobileNumber
        self.street       = street
        self.residence    = residence
        self.city         = city
        self.instruction  = instruction
        
        RecipientAddress.availableRecipientAddressId += 1
    }
}
