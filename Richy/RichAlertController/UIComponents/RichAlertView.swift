//
//  RichAlertView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

protocol RichAlertViewDelegate: class {
    func didTapBackground(from view: RichAlertView)
}

class RichAlertView: UIView {
    
    weak var delegate: RichAlertViewDelegate?
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    private let type: RichAlertController.Style
    
    private var content: RichAlertContentView!

    init(type: RichAlertController.Style, contents: [UIView]) {
        self.type = type
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    func animateView() {}
}
