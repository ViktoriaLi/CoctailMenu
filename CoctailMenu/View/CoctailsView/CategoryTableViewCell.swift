//
//  CategoryTableViewCell.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configure(filter: Drink) {
        categoryNameLabel.text = filter.category
    }

}
