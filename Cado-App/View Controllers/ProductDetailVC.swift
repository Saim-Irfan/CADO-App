//
//  ProductDetailVC.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class ProductDetailVC: UIViewController {
    static let storyboardIdentifier = "productDetailVC"
    
    @IBOutlet var productNameLbl: UILabel!
    
    var productId: Int!
    
    private let productManager = ProductManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product = productManager.get(byId: productId)!
        
        productNameLbl.text = product.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
