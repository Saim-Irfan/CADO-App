//
//  CartItemCell.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class CartItemCell: UITableViewCell {
    static let identifier = "cartItemCell"
    
    
    @IBOutlet var mainImgView: UIImageView!
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var shortDescriptionLbl: UILabel!
    
    
    @IBOutlet var quantityTxtField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
