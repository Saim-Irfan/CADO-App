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
    
    func loginUser(userId: Int) {
        LoggedUser.loggedInUserId = userId
    }
    
    func getLoggedInUserId() -> Int? {
        LoggedUser.loggedInUserId
    }
    
    func logoutUser() {
        LoggedUser.loggedInUserId = nil
    }
}
