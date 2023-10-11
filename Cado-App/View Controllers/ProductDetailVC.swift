//
//  ProductDetailVC.swift
//  Cado-App
//
//  Created by Saim on 28/09/2023.
//

import UIKit

class ProductDetailVC: UIViewController {
    static let storyboardIdentifier = "productDetailVC"
    
    
    @IBOutlet var imageSliderClctionView: UICollectionView!
    @IBOutlet var imageSliderPageControl: UIPageControl!
    
    
    @IBOutlet var productNameLbl:       UILabel!
    @IBOutlet var shortDescriptionLbl:  UILabel!
    @IBOutlet var priceLbl:             UILabel!
    @IBOutlet var descriptionLbl:       UILabel!
    
    
    @IBOutlet var attributeStackView: UIStackView!
    @IBOutlet var attributeStackViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var quantityTableView: UITableView!
    
    
    @IBOutlet var addToCartBtn: PrimaryButton!
    @IBOutlet var wishlistImgView: UIImageView!
    
    
    @IBOutlet var productScrollCollectionView: UICollectionView!
    
    
    @IBOutlet var leftScrollImg:    UIImageView!
    @IBOutlet var rightScrollImg:   UIImageView!
    @IBOutlet var pageControl:      UIPageControl!
    
    
    var productId: Int!
    
    private let productManager          = ProductManager()
    private let cartManager             = CartItemManager()
    private let wishlistItemManager     = WishlistItemManager()
    private let productAttributeManager = ProductAttributeManager()
    private let attributeItemManager    = AttributeItemManager()
    
    private let loggedInUserId      = LoggedUser.getLoggedInUserId()!
    
    private var product                 : Product!
    private var productImgUrlList       : [String] = []
    private var relatedProductList      : [Product] = []
    private var attributeList           : [ProductAttribute] = []
    
    private var itemsPerPage = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.relatedProductList = productManager.getInStockAvailable()
        self.product = productManager.get(byId: productId)!
        self.attributeList = productAttributeManager.getAll(byProductId: productId)
        
        setCartBtnEnableStatus()
        
        configureImageSliderCollectionView()
        
        configureProductAttributeStackView()
        
        productNameLbl.text = product.name
        shortDescriptionLbl.text = product.shortDescription
        priceLbl.text = "DHS \(product.price)"
        descriptionLbl.text = product.description
        
        configureQuantityTblView()
        
        configureWishlistImage()
        
        let wishlistTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleWishlist))
        wishlistImgView.isUserInteractionEnabled = true
        wishlistImgView.addGestureRecognizer(wishlistTapGesture)
        
        configureProductScrollLayout()
        configureProductScroll()
        productScrollCollectionView.tag         = CollectionViewType.productSlider.rawValue
        productScrollCollectionView.dataSource  = self
        productScrollCollectionView.delegate    = self
    }
    
    func configureImageSliderCollectionView() {
        productImgUrlList.append(product.imageUrl)
        
        product.secondaryImgUrlList.forEach { imgUrl in
            productImgUrlList.append(imgUrl)
        }
        
        imageSliderClctionView.showsHorizontalScrollIndicator = false
        
        imageSliderClctionView.tag                                          = CollectionViewType.imgSlider.rawValue
        imageSliderClctionView.delegate                                     = self
        imageSliderClctionView.dataSource                                   = self
        imageSliderClctionView.automaticallyAdjustsScrollIndicatorInsets    = true
        
        imageSliderPageControl.numberOfPages = productImgUrlList.count
        imageSliderPageControl.addTarget(self, action: #selector(handleTapOnImgSliderPageControl), for: .valueChanged)
        pageControl.addTarget(self, action: #selector(handlePageControlTap), for: .valueChanged)
    }
    
    func configureProductAttributeStackView() {
        if attributeList.isEmpty {
            return
        }
        
        let stackviewItemHeight = 70.0
        let itemSpacing = 10.0
        var stackviewHeight = 0.0
        for attribute in attributeList {
            let attributeItemList = attributeItemManager.getAll(byAttributeId: attribute.id)
            
            let attributeView = ProductAttributeView()
            attributeView.translatesAutoresizingMaskIntoConstraints = false
            attributeView.heightAnchor.constraint(equalToConstant: stackviewItemHeight).isActive = true
            
            
            attributeView.configure(title: attribute.name, attributeItemList: attributeItemList)
            
            attributeStackView.addArrangedSubview(attributeView)
            stackviewHeight += stackviewItemHeight + itemSpacing
        }
        
        
        attributeStackView.spacing = itemSpacing
        attributeStackViewHeight.constant = stackviewHeight
    }
    
    func configureQuantityTblView() {
        quantityTableView.dataSource                        = self
        quantityTableView.delegate                          = self
        quantityTableView.layer.borderWidth                 = 1.0
        quantityTableView.showsHorizontalScrollIndicator    = true
    }
    
    func configureWishlistImage() {
        let isAddedToWishlist = wishlistItemManager.checkIfExists(productId: productId, for: loggedInUserId)
        
        if (isAddedToWishlist) {
            wishlistImgView.tintColor = .yellow
        }
        else {
            wishlistImgView.tintColor = .gray
        }
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
    
    func configureProductScroll() {
        let productCount = relatedProductList.count
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
    
    @objc func handleTapOnImgSliderPageControl() {
        let newPageIndex = imageSliderPageControl.currentPage
        
        let newPageIndexPath = IndexPath(row: newPageIndex, section: 0)
        
        imageSliderClctionView.isPagingEnabled = false
        imageSliderClctionView.scrollToItem(at: newPageIndexPath, at: .centeredHorizontally, animated: true)
        imageSliderClctionView.isPagingEnabled = true
    }
    
    @objc func toggleWishlist() {
        let isAddedToWishlist = wishlistItemManager.checkIfExists(productId: productId, for: loggedInUserId)
        
        if isAddedToWishlist {
            wishlistItemManager.remove(productId: productId, for: loggedInUserId)
        }
        else {
            let newWishlistItem = WishlistItem(userId: loggedInUserId, productId: productId)
            wishlistItemManager.create(newWishlistItem)
        }
        
        configureWishlistImage()
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
        MainTabBarController.showCartBadge()
        
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
        switch collectionView.tag {
        case CollectionViewType.productSlider.rawValue:
            return relatedProductList.count
        case CollectionViewType.imgSlider.rawValue:
            return productImgUrlList.count
        default:
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case CollectionViewType.productSlider.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerCell.identifier, for: indexPath) as! InnerCell
            
            let product = relatedProductList[indexPath.row]
            
            cell.titleLbl.text = product.name
            cell.mainImgView.loadImage(url: URL(string: product.imageUrl)!)
            
            return cell
        case CollectionViewType.imgSlider.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSliderCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageSliderCollectionViewCell
            
            let productImgUrl = productImgUrlList[indexPath.row]
            cell.mainImgView.loadImage(url: URL(string: productImgUrl)!)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension ProductDetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case CollectionViewType.productSlider.rawValue:
            let itemIndex = indexPath.row
            
            let pageNumber = Int(ceil(Double(itemIndex / itemsPerPage)))
            
            pageControl.currentPage = pageNumber
        default:
            return
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: imageSliderClctionView.contentOffset, size: imageSliderClctionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = imageSliderClctionView.indexPathForItem(at: visiblePoint) else {
            return
        }
        
        imageSliderPageControl.currentPage = visibleIndexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case CollectionViewType.productSlider.rawValue:
            let product = relatedProductList[indexPath.row]
            
            let productDetailVC = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.storyboardIdentifier) as! ProductDetailVC
            productDetailVC.productId = product.id
            navigationController?.pushViewController(productDetailVC, animated: true)
        default:
            return
        }
    }
}

extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = imageSliderClctionView.bounds.size
        return CGSize(width: size.width, height: size.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}



enum CollectionViewType: Int {
    case imgSlider      = 0
    case productSlider  = 1
}
