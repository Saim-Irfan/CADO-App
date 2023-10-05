//
//  OrderItemView.swift
//  Cado-App
//
//  Created by Saim on 05/10/2023.
//

import UIKit

class OrderItemView: UIView {

    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var quantityLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(String(describing: OrderItemView.self), owner: self, options: nil)![0] as! UIView
        
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    func configure(imgUrl: String, produceName: String, productPrice: Double, productQuantity: Int) {
        mainImgView.loadImage(url: URL(string: imgUrl)!)
        productNameLbl.text = produceName
        priceLbl.text = "AED \(productPrice)"
        quantityLbl.text = "Qty: \(productQuantity)"
    }
    
}
