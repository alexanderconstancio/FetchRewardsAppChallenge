//
//  CustomImageView.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    var imageCache = [String: UIImage]()
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        if urlString == "" {
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [unowned self] (data, res, error) in
            if let error = error {
                print("error getting url with session:", error)
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            guard let image = UIImage(data: imageData) else { return }
            
            self.imageCache[url.absoluteString] = image
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            }.resume()
    }
}
