//
//  ProductListingVC.swift
//  Cado-App
//
//  Created by Saim on 06/10/2023.
//

import UIKit

class ProductListingVC: UIViewController, UICollectionViewDelegate {
    static let storyboardIdentifier = "productDetailVC"
    
    typealias Datasource = UICollectionViewDiffableDataSource<Int, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    @IBOutlet var productListingClctnView: UICollectionView!
    
    private let productManager = ProductManager()
    private let searchController = UISearchController()
    
    private var productList         : [Product] = []
    private var filteredProductList : [Product] = []
    
    private var datasource: Datasource!
    
    override func viewWillAppear(_ animated: Bool) {
        self.productList    = productManager.getAll()
        filteredProductList = productList
        
        tabBarController?.navigationItem.title = "Search Product"
        
        configureSearchController()
        
        if self.productList.isEmpty {
            
        }
        else {
            configureDatasource()
            applySnapshot()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productListingClctnView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.navigationItem.searchController = nil
    }
    
    func configureDatasource() {
        datasource = Datasource(collectionView: productListingClctnView, cellProvider: { collectionView, indexPath, productId in
            let product = self.productList.first { product in
                product.id == productId
            }!
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListingCVCell.reuseIdentifier, for: indexPath) as! ProductListingCVCell
            
            cell.mainImgView.loadImage(url: URL(string: product.imageUrl)!)
            cell.productNameLbl.text = product.name
            cell.shortDescriptionLbl.text = product.shortDescription
            cell.priceLbl.text = "\(product.price) AED"
            
            
            return cell
            
            
        })
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([0])
        
        var productIdList: [Int] = []
        for product in filteredProductList {
            productIdList.append(product.id)
        }
        
        snapshot.appendItems(productIdList)
        
        datasource.apply(snapshot)
    }
    
    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        
        
        let offset = UIOffset(horizontal: (searchController.searchBar.frame.width - 200) / 2, vertical: 0)
        searchController.searchBar.setPositionAdjustment(offset, for: .search)
        
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        
        tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
        tabBarController?.navigationItem.searchController = searchController
    }
    
}

extension ProductListingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.storyboardIdentifier) as! ProductDetailVC
        
        productVC.productId = filteredProductList[indexPath.row].id
        
        navigationController?.pushViewController(productVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = productListingClctnView.bounds.width
        
        return CGSize(width: collectionViewWidth / 2 - 20, height: collectionViewWidth / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


extension ProductListingVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        if searchText.isEmpty {
            filteredProductList = productList
            applySnapshot()
        }
        else {
            self.filteredProductList = self.productList.filter {
                return $0.name.lowercased().contains(searchText.lowercased())
            }
            
            applySnapshot()
        }
    }
}
