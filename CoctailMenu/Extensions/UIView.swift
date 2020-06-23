//
//  UIView.swift
//  CoctailMenu
//
//  Created by Mac Developer on 23.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

extension UIView {
    func addGrayShadow() {
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = .init(width: 0, height: 4)
        self.layer.shadowRadius = 4
    }
}
