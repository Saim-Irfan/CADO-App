//
//  SmallBannerCell.swift
//  Cado-App
//
//  Created by Saim on 26/09/2023.
//

import UIKit

class SmallBannerCell: UICollectionViewCell {
    static let identifier = "smallBannerCell"
    
    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var mainLblView: UILabel!
    
    func configure(imageURL: String, title: String) {
        let imageUrl = URL(string: imageURL)!
        
        
        mainImgView.loadImage(url: imageUrl)
        mainLblView.text = title
    }
}
