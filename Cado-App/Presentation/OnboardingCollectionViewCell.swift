//
//  OnboardingCollectionViewCell.swift
//  Cado-App
//
//  Created by Saim on 22/09/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var titleMsg: UILabel!
    @IBOutlet var contentMsg: UILabel!
    
    func configure(img: UIImage, title: String, content: String) {
        mainImg.image = img
        titleMsg.text = title
        contentMsg.text = content
        
        contentMode = .scaleAspectFill
    }
}
