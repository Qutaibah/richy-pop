//
//  RichAlertPopupView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class RichAlertPopoverView: RichAlertView {
    
    override var delegate: RichAlertViewDelegate? {
        didSet {
            setupComponents()
            setupConstraints()
        }
    }
    
    private let type: RichAlertController.Style
    
    private var content: RichAlertContentView!

    override init(type: RichAlertController.Style, contents: [UIView]) {
        self.type = type
        super.init(type: type, contents: contents)
        content = RichAlertContentView(views: contents)
        content.edgeInsets = edgeInsets
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupComponents() {
        backgroundColor = .clear
        addSubview(content)
    }
    
    private func setupConstraints() {
        content.anchor(top: topAnchor,
                 leading: leadingAnchor,
                 bottom: bottomAnchor,
                 trailing: trailingAnchor)
        content.widthAnchor.constraint(lessThanOrEqualToConstant: type == .alert ? 330 : 410).isActive = true
        content.setContentCompressionResistancePriority(.init(1000), for: .vertical)
    }
}
