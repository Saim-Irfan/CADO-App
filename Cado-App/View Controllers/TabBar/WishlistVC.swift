//
//  WishlistVC.swift
//  Cado-App
//
//  Created by Saim on 06/10/2023.
//

import UIKit

class WishlistVC: UIViewController {
    static let storyboardIdentifier = "wishlistVC"
    
    @IBOutlet var browseGiftLbl: UILabel!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var totalItemLbl: UILabel!
    
    @IBOutlet var wishlistTblView: UITableView!
    
    private let wishlistItemManager     = WishlistItemManager()
    private let productManager          = ProductManager()
    private let cartItemManager         = CartItemManager()
    private let loggedInUserId = LoggedUser.getLoggedInUserId()!
    
    private var wishlistItemList: [WishlistItem] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Wishlist"
        
        self.wishlistItemList = wishlistItemManager.getAll(byUserId: loggedInUserId)
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeToHomePage))
        browseGiftLbl.isUserInteractionEnabled = true
        browseGiftLbl.addGestureRecognizer(tapGesture)

        wishlistTblView.dataSource = self
        wishlistTblView.delegate = self
    }
    
    @objc func changeToHomePage() {
        tabBarController?.selectedIndex = HomeVC.tabbarIndex
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
            self.cartItemManager.addToCart(userId: self.loggedInUserId, productId: productId, quantity: 1)
            
            MainTabBarController.showCartBadge()
            
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
