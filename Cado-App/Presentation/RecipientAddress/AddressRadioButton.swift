//
//  AddressRadioButton.swift
//  Cado-App
//
//  Created by Saim on 04/10/2023.
//

import UIKit

class AddressRadioButton: UIButton {
    override func awakeFromNib() {
        configuration?.title = ""
                
        layer.borderColor = CGColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
        layer.borderWidth = 1.0
        layer.cornerRadius = frame.height / 2
        
        backgroundColor = .clear
        tintColor = .clear
    }
    
    func setAsEnabled() {
        backgroundColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
    }
    
    func setAsDisabled() {
        backgroundColor = .clear
    }
}
