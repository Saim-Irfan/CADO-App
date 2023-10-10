//
//  MainTabBarController.swift
//  Cado-App
//
//  Created by Saim on 10/10/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    static private var tabBarviewControllerList: [UIViewController] = []
    static private let cartItemManager = CartItemManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainTabBarController.tabBarviewControllerList = []
        addViewController(with: HomeVC.storyboardIdentifier, title: "Home", image: UIImage(systemName: "house")!)
        addViewController(with: ProductListingVC.storyboardIdentifier, title: "Search", image: UIImage(systemName: "magnifyingglass")!)
        addViewController(with: CartVC.storyboardIdentifier, title: "Cart", image: UIImage(systemName: "cart")!)
        addViewController(with: WishlistVC.storyboardIdentifier, title: "Wishlist", image: UIImage(systemName: "heart")!)
        addViewController(with: OrderHistoryVC.storyboardIdentifier, title: "Orders", image: UIImage(systemName: "doc.text")!)
        
        MainTabBarController.showCartBadge()
}
    
    private func addViewController(with identifier: String, title: String, image: UIImage) {
        guard let newVC = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            return
        }
        newVC.tabBarItem.title = title
        newVC.tabBarItem.image = image
        
        MainTabBarController.tabBarviewControllerList.append(newVC)
        
        setViewControllers(MainTabBarController.tabBarviewControllerList, animated: true)
    }
    
    static func showCartBadge() {
        let loggedInUserId      = LoggedUser.getLoggedInUserId()!
        let userCartItemList    = MainTabBarController.cartItemManager.getAll(byUserId: loggedInUserId)
        
        for viewController in tabBarviewControllerList where viewController is CartVC {
            let itemCount = userCartItemList.count
            if itemCount > 0 {
                viewController.tabBarItem.badgeValue = itemCount.description
            }
            
            return
        }
    }
}
