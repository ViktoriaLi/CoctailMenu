//
//  TableViewFooter.swift
//  CoctailMenu
//
//  Created by Mac Developer on 23.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class TableViewFooter: UIView {

    @IBOutlet var contentView: UIView!
    
    weak var delegate: ScrollToTopDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init(delegate: ScrollToTopDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    private func loadFromNib() {
        Bundle.main.loadNibNamed("TableViewFooter", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func returnToTopButtonTapped(_ sender: UIButton) {
        delegate?.returnToTop()
    }

}
