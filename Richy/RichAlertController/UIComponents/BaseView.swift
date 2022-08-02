//
//  BaseView.swift
//  Richy
//
//  Created by Qutaibah Essa on 19/04/2020.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

public class BaseView: UIView {
    
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    public var contentHeight: CGFloat = 0
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            contentView.layer.borderWidth = borderWidth
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            contentView.layer.cornerRadius = cornerRadius
        }
    }
    
    public var contentView: UIView! {
        didSet {
            setupComponents()
            setNeedsUpdateConstraints()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupComponents() {
        addSubview(contentView)
    }
    
    func setupConstraints() {
        contentView.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: trailingAnchor,
                           topConstant: edgeInsets.top,
                           leadingConstant: edgeInsets.left,
                           bottomConstant: edgeInsets.bottom,
                           trailingConstant: edgeInsets.right,
                           heightConstant: contentHeight)
    }
    
    public override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
}
