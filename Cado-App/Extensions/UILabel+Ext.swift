//
//  UILabel+Ext.swift
//  Cado-App
//
//  Created by Saim on 26/09/2023.
//

import UIKit

extension UILabel {
    func showWarningLabel(text: String) {
        textColor = .red
        isHidden = false
        self.text = text
    }
    
    func showSuccessLabel(text: String) {
        textColor = .systemGreen
        isHidden = false
        self.text = text
    }
    
    func hideLabel() {
        isHidden = true
        text = ""
    }
}
