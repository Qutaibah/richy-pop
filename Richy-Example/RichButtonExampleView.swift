//
//  RichButtonExampleView.swift
//  Richy-Example
//
//  Created by Qutaibah Essa on 21/04/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit
import Richy

class RichButtonExampleView: UIView {
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    var contentHeight: CGFloat = 0
        
    private lazy var contentView: UIStackView = {
        let stk = UIStackView()
        stk.alignment = .fill
        stk.distribution = .fillEqually
        stk.spacing = 20
        stk.axis = .vertical
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupComponents() {
        let b = FillableButton(title: "Try Me", image: #imageLiteral(resourceName: "delete"), semantic: .default, style: .primary, actionHandler: nil)
        let b1 = RichButton(type: .filled(.primary),
                            title: "Title",
                            image: #imageLiteral(resourceName: "delete"),
                            semantic: .default,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        b1.showBadge(count: 10)
        b1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let b2 = RichButton(type: .filled(.primary),
                            title: "Title",
                            image: #imageLiteral(resourceName: "delete"),
                            semantic: .reversed,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b3 = RichButton(type: .filled(.primary),
                            title: nil,
                            image: #imageLiteral(resourceName: "delete"),
                            semantic: .reversed,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b4 = RichButton(type: .filled(.primary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b5 = RichButton(type: .filled(.secondary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b6 = RichButton(type: .bordered(.primary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b7 = RichButton(type: .clear(.primary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: UIEdgeInsets.tens,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        contentView.addArrangedSubview(b)
        contentView.addArrangedSubview(b1)
        contentView.addArrangedSubview(b2)
        contentView.addArrangedSubview(b3)
        contentView.addArrangedSubview(b4)
        contentView.addArrangedSubview(b5)
        contentView.addArrangedSubview(b6)
        contentView.addArrangedSubview(b7)

        addSubview(contentView)
    }
    
    func setupConstraints() {
        contentView.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: nil,
                           trailing: trailingAnchor,
                           topConstant: edgeInsets.top,
                           leadingConstant: edgeInsets.left,
                           bottomConstant: edgeInsets.bottom,
                           trailingConstant: edgeInsets.right,
                           heightConstant: contentHeight)
        contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: edgeInsets.bottom).isActive = true
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
}
