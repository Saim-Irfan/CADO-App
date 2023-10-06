//
//  WishlistVC.swift
//  Cado-App
//
//  Created by Saim on 06/10/2023.
//

import UIKit

class WishlistVC: UIViewController {
    static let loggedInUserId = LoggedUser.getLoggedInUserId()!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var totalItemLbl: UILabel!
    
    @IBOutlet var wishlistTblView: UITableView!
    
    private let wishlistItemManager     = WishlistItemManager()
    private let productManager          = ProductManager()
    private let cartItemManager         = CartItemManager()
    
    private var wishlistItemList: [WishlistItem] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Wishlist"
        
        self.wishlistItemList = wishlistItemManager.getAll(byUserId: WishlistVC.loggedInUserId)
        
        if self.wishlistItemList.isEmpty {
            mainView.isHidden = true
        }
        else {
            mainView.isHidden = false
            wishlistTblView.reloadData()
        }
        
        totalItemLbl.text = "\(wishlistItemList.count) items"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wishlistTblView.dataSource = self
        wishlistTblView.delegate = self
    }
}

extension WishlistVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishlistItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishlistTblCell.reuseIdentifier) as! WishlistTblCell
        
        let wishlistItem = wishlistItemList[indexPath.row]
        let product = productManager.get(byId: wishlistItem.productId)!
        
        cell.mainImg                    .loadImage(url: URL(string: product.imageUrl)!)
        cell.productNameLbl.text        = product.name
        cell.shortDescriptionLbl.text   = product.shortDescription
        
        cell.productId                  = product.id
        cell.addToCartCallback          = { productId in
            self.cartItemManager.addToCart(userId: WishlistVC.loggedInUserId, productId: productId, quantity: 1)
            
            let alert = UIAlertController(title: "Added To Cart", message: "The following product has been added to the cart", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
        
        return cell
    }
}


extension WishlistVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wishlistItem = wishlistItemList[indexPath.row]
        
        let productDetailVC = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.storyboardIdentifier) as! ProductDetailVC
        productDetailVC.productId = wishlistItem.productId
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
