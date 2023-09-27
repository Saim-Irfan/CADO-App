//
//  BannerCell.swift
//  Cado-App
//
//  Created by Saim on 26/09/2023.
//

import UIKit

class BigBannerCell: UICollectionViewCell {
    static let identifier = "bigBannerCell"
    
    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    
    
    func configure(imageURL: String, title: String) {
        let imageUrl = URL(string: imageURL)!
        
        
        mainImgView.loadImage(url: imageUrl)
        titleLbl.text = title
    }
}
