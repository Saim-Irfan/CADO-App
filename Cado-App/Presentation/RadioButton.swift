//
//  RadioButton.swift
//  Cado-App
//
//  Created by Saim on 25/09/2023.
//

import UIKit

class RadioButton: UIButton {
    override func awakeFromNib() {
        configuration?.title = ""
                
        layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        layer.borderWidth = 1.0
        layer.cornerRadius = frame.height / 2
        
        backgroundColor = .white
        tintColor = .white
    }
    
    func setAsEnabled() {
        backgroundColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
        configuration?.image = UIImage(systemName: "checkmark")
    }
    
    func setAsDisabled() {
        backgroundColor = .white
        configuration?.image = nil
    }
}
