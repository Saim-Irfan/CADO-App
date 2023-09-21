//
//  UserRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

struct UserRepository: RepositoryProtocol {
    private var users: [User] = []
    
    mutating func create(record: User) {
        users.append(record)
    }
    
    func getAll() -> [User] {
        return users
    }
    
    func get(byIdentifier id: Int) -> User? {
        return users.first { user in
            user.id == id
        }
    }
    
    func update(record updatedUser: User) -> Bool {
        // No work needed here
        
        return true
    }
    
    mutating func delete(byIdentifier id: Int) -> Bool {
        guard let indexOfUserToDelete = users.firstIndex (where: { user in
            user.id == id
        }) else { return false }
        
        users.remove(at: indexOfUserToDelete)
        
        return true
    }
    
    typealias Record = User
    typealias Identifier = Int
}
