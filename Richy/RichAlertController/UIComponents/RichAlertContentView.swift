//
//  RichAlertContentView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class RichAlertContentView: BaseView {
        
    private lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.alignment = .fill
        stk.distribution = .fill
        stk.spacing = 0
        stk.axis = .vertical
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    init(views: [UIView]) {
        super.init(frame: .zero)
        addShadow()
        clipsToBounds = true
        backgroundColor = Identity.color(.white)
        layer.cornerRadius = Identity.Dimension.cornerRadius
        for view in views {
            stackView.addArrangedSubview(view)
        }
        contentView = stackView
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func animateView() {
        alpha = 0;
        frame.origin.y = frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alpha = 1.0;
            self.frame.origin.y = self.frame.origin.y - 50
        })
    }
}
