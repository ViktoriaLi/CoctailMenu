//
//  SomethingWrong.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class SomethingWrong: UIView {

    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: ErrorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init(delegate: ErrorViewDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    private func loadFromNib() {
        Bundle.main.loadNibNamed("SomethingWrong", owner: self, options: nil)
        addSubview(contentView)
        tryAgainButton.layer.cornerRadius = 8
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func tryAgainButtonTapped(_ sender: UIButton) {
        delegate?.tryAgain()
    }
}
