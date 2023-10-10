//
//  WishlistTblCell.swift
//  Cado-App
//
//  Created by Saim on 06/10/2023.
//

import UIKit

class WishlistTblCell: UITableViewCell {
    static let reuseIdentifier = "wishlistTblCell"
    
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var shortDescriptionLbl: UILabel!
    
    var productId: Int!
    var addToCartCallback: ((_ productId: Int) -> ())!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    @IBAction func addToCartBtnTapped(_ sender: PrimaryButton) {
        addToCartCallback(productId)
    }
    
}
