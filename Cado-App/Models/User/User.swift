//
//  User.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class User {
    private static var availableUserId = 1
    
    let id:          Int
    let firstName:   String
    let lastName:    String
    let email:       String
    let password:    String
    let dateOfBirth: Date
    let gender:      Gender
    let country:     String
    
    init(firstName: String, lastName: String, email: String, password: String, dob: Date, gender: Gender, country: String) {
        self.id          = Cado_App.User.availableUserId
        self.firstName   = firstName
        self.lastName    = lastName
        self.email       = email
        self.password    = password
        self.dateOfBirth = dob
        self.gender      = gender
        self.country     = country
        
        User.availableUserId += 1
    }
}


enum Gender {
    case male
    case female
}
