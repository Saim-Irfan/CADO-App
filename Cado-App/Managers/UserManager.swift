//
//  UserRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class UserManager {
    private var userRepository = UserRepository()
    
    func create(_ user: User) {
        userRepository.create(record: user)
    }
    
    func getAll() -> [User] {
        userRepository.getAll()
    }
    
    func get(byId id: Int) -> User? {
        userRepository.get(byIdentifier: id)
    }
    
    func update(_ user: User) -> Bool {
        userRepository.update(record: user)
    }
    
    func delete(byId id: Int) -> Bool {
        userRepository.delete(byIdentifier: id)
    }
    
    func checkIfExists(by id: Int) -> Bool {
        guard let _ = get(byId: id) else {
            return false
        }
        return true
    }
}
