//
//  TitleView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class TitleView: BaseView {
    
    var alignment: NSTextAlignment = .center {
        didSet {
            titleLabel.textAlignment = alignment
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = Identity.font(.h1)
        lbl.textColor = Identity.color(.darkGray)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        contentView = titleLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
