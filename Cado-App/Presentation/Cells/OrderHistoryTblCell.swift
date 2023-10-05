//
//  OrderHistoryTblCell.swift
//  Cado-App
//
//  Created by Saim on 05/10/2023.
//

import UIKit

class OrderHistoryTblCell: UITableViewCell {
    static let storyboardIdentifier = "orderHistoryTblCell"
    
    @IBOutlet var mainContainerView: UIView!
    
    @IBOutlet var orderIdLbl: UILabel!
    @IBOutlet var orderDateLbl: UILabel!
    @IBOutlet var orderStatusLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureMainContainer()
    }
    
    func configureMainContainer() {
        mainContainerView.layer.shadowColor         = UIColor.black.cgColor
        mainContainerView.layer.shadowOpacity       = 0.2
        mainContainerView.layer.shadowOffset        = .zero
        mainContainerView.layer.shadowRadius        = 5
        
        mainContainerView.layer.cornerRadius        = 5.0
        
        mainContainerView.layer.shouldRasterize     = true
        mainContainerView.layer.rasterizationScale  = UIScreen.main.scale
    }
}
