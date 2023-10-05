//
//  ProductDetailVC.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class ProductDetailVC: UIViewController {
    static let storyboardIdentifier = "productDetailVC"
    
    @IBOutlet var mainImgView:          UIImageView!
    @IBOutlet var productNameLbl:       UILabel!
    @IBOutlet var shortDescriptionLbl:  UILabel!
    @IBOutlet var priceLbl:             UILabel!
    @IBOutlet var descriptionLbl:       UILabel!
    
    
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var quantityTableView: UITableView!
    
    
    @IBOutlet var addToCartBtn: PrimaryButton!
    
    
    @IBOutlet var productScrollCollectionView: UICollectionView!
    
    
    @IBOutlet var leftScrollImg:    UIImageView!
    @IBOutlet var rightScrollImg:   UIImageView!
    @IBOutlet var pageControl:      UIPageControl!
    
    
    var productId: Int!
    
    private let productManager  = ProductManager()
    private let cartManager     = CartItemManager()
    
    
    private var product: Product!
    private var productList: [Product] = []
    
    private var itemsPerPage = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productList = productManager.getAll()
        self.product = productManager.get(byId: productId)!
        setCartBtnEnableStatus()
        
        mainImgView.loadImage(url: URL(string: product.imageUrl)!)
        productNameLbl.text = product.name
        shortDescriptionLbl.text = product.shortDescription
        priceLbl.text = "DHS \(product.price)"
        descriptionLbl.text = product.description
         
        quantityTableView.dataSource    = self
        quantityTableView.delegate      = self
        quantityTableView.layer.borderWidth = 1.0
        quantityTableView.showsHorizontalScrollIndicator = true
        
        configureProductScrollLayout()
        
        productScrollCollectionView.dataSource  = self
        productScrollCollectionView.delegate    = self
        
        configureScroll()
    }
    
    func configureProductScrollLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 15.0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        productScrollCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func configureScroll() {
        let productCount = productList.count
        var totalPagesNeeded = Int(ceil(Double(productCount / itemsPerPage)))
        
        if totalPagesNeeded > 0 {
            let extraPages = productCount % itemsPerPage
            totalPagesNeeded += extraPages
        }
        
        pageControl.numberOfPages = totalPagesNeeded
        
        pageControl.addTarget(self, action: #selector(handlePageControlTap), for: .valueChanged)
        
        configureArrows()
    }
    
    func configureArrows() {
        rightScrollImg.isUserInteractionEnabled = true
        leftScrollImg.isUserInteractionEnabled = true
        
        let rightArrowTap = UITapGestureRecognizer(target: self, action: #selector(handleRightArrowTap))
        let leftArrowTap = UITapGestureRecognizer(target: self, action: #selector(handleLeftArrowTap))
        
        rightScrollImg.addGestureRecognizer(rightArrowTap)
        leftScrollImg.addGestureRecognizer(leftArrowTap)
    }
    
    func setCartBtnEnableStatus() {
        if quantityTextField.text!.isEmpty {
            addToCartBtn.setDisabled()
        }
        else {
            addToCartBtn.setEnabled()
        }
    }
    
    @objc func handleRightArrowTap() {
        let currentPage = pageControl.currentPage
        
        let currentPageItemIndex = currentPage * itemsPerPage
        
        let firstItemIndexOfNextPage = currentPageItemIndex + itemsPerPage
        
        let nextPageIndexPath = IndexPath(row: firstItemIndexOfNextPage, section: 0)
        productScrollCollectionView.scrollToItem(at: nextPageIndexPath, at: .left, animated: true)
    }
    
    @objc func handleLeftArrowTap() {
        let currentPage = pageControl.currentPage
        
        let currentPageItemIndex = currentPage * itemsPerPage
        
        let firstItemIndexOfPreviousPage = currentPageItemIndex - itemsPerPage
        
        let previousPageIndexPath = IndexPath(row: firstItemIndexOfPreviousPage, section: 0)
        productScrollCollectionView.scrollToItem(at: previousPageIndexPath, at: .left, animated: true)
    }
    
    @objc func handlePageControlTap() {
        let newPage = pageControl.currentPage
        
        let newPageItemIndex = newPage * itemsPerPage
        
        let newPageIndexPath = IndexPath(row: newPageItemIndex, section: 0)
        productScrollCollectionView.scrollToItem(at: newPageIndexPath, at: .left, animated: true)
    }
    
    @IBAction func quantityBeginEditing(_ sender: UITextField) {
        sender.endEditing(true)
        
        if quantityTableView.isHidden {
            quantityTableView.isHidden = false
        }
        else {
            quantityTableView.isHidden = true
        }
        
    }
    
    @IBAction func addToCartBtnTapped(_ sender: PrimaryButton) {
        let currentUserId = LoggedUser.getLoggedInUserId()!
        
        cartManager.addToCart(userId: currentUserId, productId: productId, quantity: Int(quantityTextField.text!)!)
        
        let alert = UIAlertController(title: "Product Added", message: "You have added this item to cart", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)

        present(alert, animated: true)
    }
}

extension ProductDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product.quantity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quantityCell")!
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
}

extension ProductDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quantityTextField.text = "\(indexPath.row + 1)"
        quantityTableView.isHidden = true
        
        setCartBtnEnableStatus()
    }
}

extension ProductDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productManager.getAll().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerCell.identifier, for: indexPath) as! InnerCell
        
        let product = productList[indexPath.row]
        
        cell.titleLbl.text = product.name
        cell.mainImgView.loadImage(url: URL(string: product.imageUrl)!)
        
        return cell
    }
}

extension ProductDetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemIndex = indexPath.row
        
        let pageNumber = Int(ceil(Double(itemIndex / itemsPerPage)))
        
        pageControl.currentPage = pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        
        
        let productDetailVC = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.storyboardIdentifier) as! ProductDetailVC
        productDetailVC.productId = product.id
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
