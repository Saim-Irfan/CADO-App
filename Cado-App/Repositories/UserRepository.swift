//
//  UserRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct UserRepository: RepositoryProtocol {
    private static var users: [User] = []
    
    mutating func create(record: User) {
        UserRepository.users.append(record)
    }
    
    func getAll() -> [User] {
        return UserRepository.users
    }
    
    func get(byIdentifier id: Int) -> User? {
        return UserRepository.users.first { user in
            user.id == id
        }
    }
    
    func update(record updatedUser: User) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        guard let indexOfUserToDelete = UserRepository.users.firstIndex (where: { user in
            user.id == id
        }) else { return false }
        
        UserRepository.users.remove(at: indexOfUserToDelete)
        
        return true
    }
    
    typealias Record = User
    typealias Identifier = Int
}
