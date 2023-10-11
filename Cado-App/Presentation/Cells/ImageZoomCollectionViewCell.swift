//
//  ImageZoomCollectionViewCell.swift
//  Cado-App
//
//  Created by Saim on 11/10/2023.
//

import UIKit

class ImageZoomCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "imageZoomCollectionViewCell"
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        
        scrollView.delegate = self
    }
}

extension ImageZoomCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
}
