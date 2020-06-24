//
//  ImageCacheManager.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class ImageCaheManager {
    
    static private var imageCache = NSCache<NSString, UIImage>()

    static func loadImage(from url: String?, complition: @escaping((UIImage?) -> Void)) {
        guard let sourceURL = url, let urlFromString = URL(string: sourceURL) else {
            return
        }
        if let cacheImage = imageCache.object(forKey: sourceURL as NSString) {
            complition(cacheImage)
            return
        }
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let data = try? Data(contentsOf: urlFromString), let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: sourceURL as NSString)
                complition(image)
            }
        }
    }
}
