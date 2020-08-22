//
//  ImageFromSource.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 28/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import Foundation
import UIKit
let imageCache = NSCache<NSString, AnyObject>()
class ImageFromSource: UIImageView {
    
    var imageUrlString: String?
    func loadImageUsingUrlString(imageUrl: String,resize: Bool,targetSize: CGSize) {
        
        imageUrlString = imageUrl
        
        guard let url = URL(string: imageUrl) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: imageUrl as NSString) as? UIImage {
            
            if resize {
                self.image = Utilities.resizeImage(image: imageFromCache, targetSize: targetSize)
            }
            else {
                self.image = imageFromCache
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { (image, response, error) in
            if let err = error {
                print("Error :: " , err.localizedDescription)
            }
            DispatchQueue.main.async {
                if let imageData = image  {
                    let imageToCache = UIImage(data: imageData)
                    if self.imageUrlString == imageUrl {
                        if resize {
                            if let imageTo = imageToCache {
                                self.image = Utilities.resizeImage(image: imageTo, targetSize: targetSize)
                            }
                        }
                        else {
                            self.image = imageToCache
                        }
                        
                    }
                    if let imagetoShow = imageToCache {
                        imageCache.setObject(imagetoShow, forKey: imageUrl as NSString)

                    }
                    
                }
                
            }
        }.resume()
    }
}
