//
//  ExtraInformationRepository.swift
//  Cado-App
//
//  Created by Saim on 21/09/2023.
//

import Foundation

class ExtraInformationManager {
    private var extraInformationRepository = ExtraInformationRepository()
    
    func create(_ extraInformation: ExtraInformation) {
        extraInformationRepository.create(record: extraInformation)
    }
    
    func getAll() -> [ExtraInformation] {
        extraInformationRepository.getAll()
    }
    
    func get(byId id: Int) -> ExtraInformation? {
        extraInformationRepository.get(byIdentifier: id)
    }
    
    func update(_ extraInformation: ExtraInformation) -> Bool {
        extraInformationRepository.update(record: extraInformation)
    }
    
    func delete(byId id: Int) -> Bool {
        extraInformationRepository.delete(byIdentifier: id)
    }
}
