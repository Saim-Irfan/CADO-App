//
//  HeaderCollectionReusableView.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "headerCollectionReusableView"

    @IBOutlet var mainLbl: UILabel!
    
    func configure(mainTitle: String) {
        mainLbl.text = mainTitle
    }
    
}
