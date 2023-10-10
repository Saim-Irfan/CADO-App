//
//  RecipientAddressView.swift
//  Cado-App
//
//  Created by Saim on 04/10/2023.
//

import UIKit

class RecipientAddressView: UIView {
    
    
    @IBOutlet var mainContainerView: UIView!
    
    @IBOutlet var mainAddressLbl: UILabel!
    @IBOutlet var secondaryAddressLbl: UILabel!
    @IBOutlet var radioBtn: AddressRadioButton!
    
    var addressIndex: Int!
    var tapCallback: ((_ addressIndex: Int) -> ())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("RecipientAddressView", owner: self, options: nil)![0] as! UIView
        
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainContainerTapped))
        mainContainerView.addGestureRecognizer(tapGesture)
    }
    

    
    @objc func mainContainerTapped() {
        tapCallback(addressIndex)
    }
}
