//
//  LoggedInUserRepository.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import Foundation

import Foundation

struct LoggedUser {
    private static var loggedInUserId: Int?
    
    static func loginUser(userId: Int) {
        LoggedUser.loggedInUserId = userId
    }
    
    static func getLoggedInUserId() -> Int? {
        LoggedUser.loggedInUserId
    }
    
    static func logoutUser() {
        LoggedUser.loggedInUserId = nil
    }
}
