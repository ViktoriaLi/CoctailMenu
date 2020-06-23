//
//  NavigationView.swift
//  CoctailMenu
//
//  Created by Mac Developer on 23.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class NavigationView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var navigationView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    private func loadFromNib() {
        Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)
        
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navigationView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        navigationView.layer.shadowOffset = .init(width: 0, height: 4)
        navigationView.layer.shadowRadius = 4
    }
}
