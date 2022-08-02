//
//  RichInputExampleView.swift
//  Richy-Example
//
//  Created by Qutaibah Essa on 21/04/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit
import Richy

class RichInputExampleView: UIView {
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    let textInput: RichTextInput = {
        let txt = RichTextInput(title: "Optional Title", placeholder: nil, text: nil) { (_) in }
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let tags: RichTags = {
        let tags = RichTags(title: "Optional Title", buttons: RichInputExampleView.buttons())
        tags.tagsHeight = 40
//        tags.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        tags.translatesAutoresizingMaskIntoConstraints = false
        return tags
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
        addSubview(textInput)
        addSubview(tags)
    }
    
    func setupConstraints() {
        textInput.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: nil,
                           trailing: trailingAnchor,
                           topConstant: edgeInsets.top,
                           leadingConstant: edgeInsets.left,
                           bottomConstant: edgeInsets.bottom,
                           trailingConstant: edgeInsets.right,
                           heightConstant: 0)
        tags.anchor(top: textInput.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         topConstant: 20,
                         leadingConstant: edgeInsets.left,
                         bottomConstant: edgeInsets.bottom,
                         trailingConstant: edgeInsets.right,
                         heightConstant: 0)
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    static func buttons() -> [RichButton] {
        let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let b = FillableButton(title: "Try Me", image: #imageLiteral(resourceName: "delete"), semantic: .default, style: .primary, contentInset: edgeInsets, actionHandler: nil)
        let b2 = RichButton(type: .filled(.primary),
                            title: "Title",
                            image: #imageLiteral(resourceName: "delete"),
                            semantic: .reversed,
                            contentInset: edgeInsets,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b3 = RichButton(type: .filled(.primary),
                            title: nil,
                            image: #imageLiteral(resourceName: "delete"),
                            semantic: .reversed,
                            contentInset: edgeInsets,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b4 = RichButton(type: .filled(.primary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: edgeInsets,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b5 = RichButton(type: .filled(.secondary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: edgeInsets,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b6 = RichButton(type: .bordered(.primary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: edgeInsets,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        let b7 = RichButton(type: .clear(.primary),
                            title: "Title",
                            image: nil,
                            semantic: .default,
                            contentInset: edgeInsets,
                            highlightingEffect: RichButton.HighlightingEffect.system,
                            actionHandler: nil)
        return [b,b4,b5,b2,b3,b6,b7]
    }
}
