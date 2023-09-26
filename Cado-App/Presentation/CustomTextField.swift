//
//  CustomTextField.swift
//  Cado-App
//
//  Created by Saim on 22/09/2023.
//

import UIKit

class CustomTextField: UITextField {
    override func awakeFromNib() {
        heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        attributedPlaceholder = NSAttributedString(
            string: self.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        
        borderStyle = .roundedRect
        layer.cornerRadius = 5.0
    }
    
    func setAsInvalid() {
        layer.borderColor = CGColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)
        layer.borderWidth = 1.0
        
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.circle"))
        imageView.tintColor = UIColor(red: 255/255, green: 0.0, blue: 0.0, alpha: 1.0)
        
        rightView = imageView
    }
    
    func setAsValid() {
        layer.borderWidth = 0.0
        
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.tintColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
        
        rightViewMode = .always
        rightView = imageView
    }
}
