//
//  ScrollableCell.swift
//  Cado-App
//
//  Created by Saim on 26/09/2023.
//

import UIKit

class ScrollableCell: UICollectionViewCell {
    static let identifier = "scrollableCell"
    
    @IBOutlet var leftImgView: UIImageView!
    @IBOutlet var rightImgView: UIImageView!
    
    @IBOutlet var mainCollectionView: UICollectionView!
    
    @IBOutlet var pageControl: UIPageControl!

    private var parent: UIViewController!
    
    private var itemsPerPage = 2

    private var productList: [Product]!
    
    
    override func awakeFromNib() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        
        pageControl.addTarget(self, action: #selector(handlePageControlTap), for: .valueChanged)
        
        configureArrows()
        
        configureLayout()
    }
    
    func configure(productList: [Product], parent: UIViewController) {
        self.productList = productList
        self.parent = parent
        
        let productCount = productList.count
        var totalPagesNeeded = Int(ceil(Double(productCount / itemsPerPage)))
        
        if totalPagesNeeded > 0 {
            let extraPages = productCount % itemsPerPage
            totalPagesNeeded += extraPages
        }
        
        pageControl.numberOfPages = totalPagesNeeded
        pageControl.currentPage = 0
    }
    
    func configurePageController() {
        
    }
    
    func configureArrows() {
        rightImgView.isUserInteractionEnabled = true
        leftImgView.isUserInteractionEnabled = true
        
        let rightArrowTap = UITapGestureRecognizer(target: self, action: #selector(handleRightArrowTap))
        let leftArrowTap = UITapGestureRecognizer(target: self, action: #selector(handleLeftArrowTap))
        
        rightImgView.addGestureRecognizer(rightArrowTap)
        leftImgView.addGestureRecognizer(leftArrowTap)
    }
    
    
    func configureLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 10.0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        mainCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    @objc func handlePageControlTap() {
        let newPage = pageControl.currentPage
        
        let newPageItemIndex = newPage * itemsPerPage
        
        let newPageIndexPath = IndexPath(row: newPageItemIndex, section: 0)
        mainCollectionView.scrollToItem(at: newPageIndexPath, at: .left, animated: true)
    }
    
    @objc func handleRightArrowTap() {
        let currentPage = pageControl.currentPage
        
        let currentPageItemIndex = currentPage * itemsPerPage
        
        let firstItemIndexOfNextPage = currentPageItemIndex + itemsPerPage
        
        let nextPageIndexPath = IndexPath(row: firstItemIndexOfNextPage, section: 0)
        mainCollectionView.scrollToItem(at: nextPageIndexPath, at: .left, animated: true)
    }
    
    @objc func handleLeftArrowTap() {
        let currentPage = pageControl.currentPage
        
        let currentPageItemIndex = currentPage * itemsPerPage
        
        let firstItemIndexOfPreviousPage = currentPageItemIndex - itemsPerPage
        
        let previousPageIndexPath = IndexPath(row: firstItemIndexOfPreviousPage, section: 0)
        mainCollectionView.scrollToItem(at: previousPageIndexPath, at: .left, animated: true)
    }
}

extension ScrollableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerCell.identifier, for: indexPath) as! InnerCell
        
        let product = productList[indexPath.row]
        
        cell.titleLbl.text = product.name
        cell.mainImgView.loadImage(url: URL(string: product.imageUrl)!)
        
        return cell
    }
}


extension ScrollableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemIndex = indexPath.row
        
        let pageNumber = Int(ceil(Double(itemIndex / itemsPerPage)))
        
        pageControl.currentPage = pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        
        
        let productDetailVC = parent.storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.storyboardIdentifier) as! ProductDetailVC
        productDetailVC.productId = product.id
        parent.navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
