//
//  UIImage+Ext.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    func loadImage(url: URL) {
        image = nil
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage(systemName: "network")
            }
        }.resume()
    }
}
