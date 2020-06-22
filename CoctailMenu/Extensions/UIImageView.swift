//
//  UIImageView.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(from url: String?) {
        if let sourceURL = url {
            if let cacheImage = imageCache.object(forKey: sourceURL as NSString) {
                self.image = cacheImage
                return
            }
            let queue = DispatchQueue.global(qos: .userInitiated)
            if let urlFromString = URL(string: sourceURL) {
                queue.async { [weak self] in
                    if let data = try? Data(contentsOf: urlFromString), let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: sourceURL as NSString)
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
