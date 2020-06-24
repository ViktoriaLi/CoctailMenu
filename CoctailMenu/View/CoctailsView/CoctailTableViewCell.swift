//
//  CoctailTableViewCell.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class CoctailTableViewCell: UITableViewCell {

    @IBOutlet weak var coctailImageView: UIImageView!
    @IBOutlet weak var coctailNameLabel: UILabel!
    
    override func prepareForReuse() {
        coctailNameLabel.text = ""
        coctailImageView.image = nil
    }
    
    func configure(coctail: Coctail) {
        coctailNameLabel.text = coctail.name
        coctailImageView.image = nil
        ImageCaheManager.loadImage(from: coctail.imageUrl + "/preview") { image in
            DispatchQueue.main.async {
                self.coctailImageView.image = image
            }
        }
    }

}
