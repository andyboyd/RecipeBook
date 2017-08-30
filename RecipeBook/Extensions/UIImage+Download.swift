//
//  UIImage+Download.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    // Helper function to asynchronously downlod an image from a remote path. The path should be a valid URL.
    class func downloadImage(at path: String, completion: @escaping (_ image: UIImage) -> Void) {
        // Download the image (URLSession's caching might be enough to make this optimal, but needs tested to be sure. If not, could implement an image cache to optimise this)
        NetworkManager.getData(at: path, success: { (data) in
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("couldn't convert data at \(path) into UIImage")
            }
        }, failure: { (error) in
            print("couldn't get image at \(path)")
        })
    }
}
