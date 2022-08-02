//
//  RichItemActions.swift
//  Richy
//
//  Created by Qutaibah Essa on 05/07/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

public class RichItemActions: BaseView {
    
    public var identifier: Any?
    
    public var onCopy: (() -> Void)? {
        didSet {
            updateStack()
        }
    }
    
    public var onEdit: (() -> Void)? {
        didSet {
            updateStack()
        }
    }
    
    public var onRemove: (() -> Void)? {
        didSet {
            updateStack()
        }
    }
    
    public var onShow: (() -> Void)? {
        didSet {
            updateStack()
        }
    }
    
    lazy var copyButton: RichButton = {
        let btn = RichButton(type: .filled(.secondary)) { [weak self] (button) in
            self?.onCopy?()
        }
        let bundle = Bundle(for: type(of: self))
        btn.image = UIImage(named: "copy", in: bundle, compatibleWith: nil)
        btn.imageView.contentMode = .center
        btn.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    lazy var removeButton: RichButton = {
        let btn = RichButton(type: .filled(.destructive)) { [weak self] (button) in
            self?.onRemove?()
        }
        let bundle = Bundle(for: type(of: self))
        btn.image = UIImage(named: "remove", in: bundle, compatibleWith: nil)
        btn.cornerRadius = 8
        btn.imageView.contentMode = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    lazy var editButton: RichButton = {
        let btn = RichButton(type: .filled(.primary)) { [weak self] (button) in
            self?.onEdit?()
        }
        let bundle = Bundle(for: type(of: self))
        btn.image = UIImage(named: "edit", in: bundle, compatibleWith: nil)
        btn.cornerRadius = 8
        btn.imageView.contentMode = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    lazy var showButton: RichButton = {
        let btn = RichButton(type: .filled(.primary)) { [weak self] (button) in
            self?.onShow?()
        }
        let bundle = Bundle(for: type(of: self))
        btn.image = UIImage(named: "eye", in: bundle, compatibleWith: nil)
        btn.cornerRadius = 8
        btn.imageView.contentMode = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fillEqually
        stk.alignment = .fill
        stk.spacing = 10
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        copyButton.widthAnchor.constraint(equalTo: copyButton.heightAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor).isActive = true
        removeButton.widthAnchor.constraint(equalTo: removeButton.heightAnchor).isActive = true
        showButton.widthAnchor.constraint(equalTo: showButton.heightAnchor).isActive = true
        edgeInsets = .zero
        addSubview(stackView)
        contentView = stackView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStack() {
        if onCopy != nil {
            stackView.addArrangedSubview(copyButton)
        } else {
            stackView.removeArrangedSubview(copyButton)
        }
        if onShow != nil {
            stackView.addArrangedSubview(showButton)
        } else {
            stackView.removeArrangedSubview(showButton)
        }
        if onEdit != nil {
            stackView.addArrangedSubview(editButton)
        } else {
            stackView.removeArrangedSubview(editButton)
        }
        if onRemove != nil {
            stackView.addArrangedSubview(removeButton)
        } else {
            stackView.removeArrangedSubview(removeButton)
        }
    }
}
