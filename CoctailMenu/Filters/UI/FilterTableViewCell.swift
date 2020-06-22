//
//  FilterTableViewCell.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var filterCheckMarkButton: UIButton!

    @IBAction func filterCheckMarkButtonTapped(_ sender: UIButton) {
    }
    
    func configure(filter: Drink) {
        filterNameLabel.text = filter.category
    }
}
