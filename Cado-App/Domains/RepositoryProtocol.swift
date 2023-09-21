//
//  RepositoryProtocol.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Record
    associatedtype Identifier
    
    mutating func create(record: Record)
    func getAll() -> [Record]
    func get(byIdentifier: Identifier) -> Record?
    func update(record: Record) -> Bool
    mutating func delete(byIdentifier: Identifier) -> Bool
}
