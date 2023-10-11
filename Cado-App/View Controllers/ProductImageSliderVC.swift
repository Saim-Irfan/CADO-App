//
//  ProductImageSliderVC.swift
//  Cado-App
//
//  Created by Saim on 11/10/2023.
//

import UIKit

class ProductImageSliderVC: UIViewController {
    static let storyboardIdentifier = "productImageSliderVC"
    
    @IBOutlet var imageSliderClctionView: UICollectionView!
    
    var imageUrlList: [String] = []
    
    override func viewDidLoad() {
        imageSliderClctionView.delegate     = self
        imageSliderClctionView.dataSource   = self
    }
}

extension ProductImageSliderVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageUrlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageZoomCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageZoomCollectionViewCell
        
        cell.mainImageView.loadImage(url: URL(string: imageUrlList[indexPath.row])!)
        
        return cell
    }
}

extension ProductImageSliderVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
