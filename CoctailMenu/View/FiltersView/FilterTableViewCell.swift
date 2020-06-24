//
//  FilterTableViewCell.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol CheckMarkStatus: class {
    func changeCheckMarkVisibility(cellIndex: IndexPath, visibility: Bool)
}

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var filterCheckMarkButton: UIButton!

    weak var delegate: CheckMarkStatus?
    var selfIndex: IndexPath?
    
    override func prepareForReuse() {
        filterCheckMarkButton.isHidden = false
    }
    
    @IBAction func filterCheckMarkButtonTapped(_ sender: UIButton) {
        filterCheckMarkButton.isHidden = true
        if let index = selfIndex {
            delegate?.changeCheckMarkVisibility(cellIndex: index, visibility: false)
        }
    }
    
    func configure(filter: Drink, cellIndex: IndexPath) {
        selfIndex = cellIndex
        filterNameLabel.text = filter.category
        if filter.isSelected {
            filterCheckMarkButton.isHidden = false
        } else {
            filterCheckMarkButton.isHidden = true
        }
    }
}
