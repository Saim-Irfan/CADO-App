//
//  ProductListingCVCell.swift
//  Cado-App
//
//  Created by Saim on 06/10/2023.
//

import UIKit

class ProductListingCVCell: UICollectionViewCell {
    static let reuseIdentifier = "productListingCVCell"
    
    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var shortDescriptionLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    
}
