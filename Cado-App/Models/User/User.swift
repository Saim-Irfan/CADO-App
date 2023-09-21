//
//  User.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class User {
    let id:          Int
    let firstName:   String
    let lastName:    String
    let email:       String
    let password:    String
    let dateOfBirth: Date
    let gender:      Gender
    let country:     String
    let cartId:      Int
    let wishlisId:   Int
    
    init(id: Int, firstName: String, lastName: String, email: String, password: String, dob: Date, gender: Gender, country: String, cartId: Int, wishlistId: Int) {
        self.id          = id
        self.firstName   = firstName
        self.lastName    = lastName
        self.email       = email
        self.password    = password
        self.dateOfBirth = dob
        self.gender      = gender
        self.country     = country
        self.cartId      = cartId
        self.wishlisId   = wishlistId
    }
}


enum Gender {
    case male
    case female
}
