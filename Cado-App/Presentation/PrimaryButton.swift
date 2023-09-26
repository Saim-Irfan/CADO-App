//
//  PrimaryButton.swift
//  Cado-App
//
//  Created by Saim on 22/09/2023.
//

import UIKit

class PrimaryButton: UIButton {
    override func awakeFromNib() {
        heightAnchor.constraint(equalToConstant: 44.0).isActive = true

        layer.cornerRadius = 10.0
        backgroundColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
        
        tintColor = .black
    }
    
    func setDisabled() {
        isEnabled = false
        layer.opacity = 0.4
    }
    
    func setEnabled() {
        isEnabled = true
        layer.opacity = 1.0
    }
}
