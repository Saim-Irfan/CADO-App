//
//  FBButton.swift
//  Cado-App
//
//  Created by Saim on 22/09/2023.
//

import UIKit

class FBButton: UIButton {
    
    override func awakeFromNib() {
        setColors()
        
        layer.cornerRadius = 10.0
        
        heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        //        contentHorizontalAlignment = .left
        
        //        let imageWidth = configuration?.image?.size.width ?? 0
        //        let titleWidth = titleLabel?.intrinsicContentSize.width ?? 0
        //
        //        imageView?.contentMode = .scaleAspectFit
        //
        //        let spacing = CGFloat(10) // Adjust the desired spacing
        //
        //        let leftInset = (bounds.width - (imageWidth + spacing + titleWidth)) / 2
        //
        //        configuration?.imagePadding = leftInset
    }
    
    func setColors() {
        backgroundColor = UIColor(red: 61/255, green: 81/255, blue: 147/255, alpha: 1.0)
        tintColor = .white
    }
}
