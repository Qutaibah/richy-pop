//
//  RichForm.swift
//  Richy
//
//  Created by Qutaibah Essa on 12/07/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

public class RichFormView: BaseView {
    
    public var title: String? {
        didSet {
            titleLabel.isHidden = title?.isEmpty != false
            titleLabel.titleLabel.text = title
        }
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            titleLabel.backgroundColor = backgroundColor
        }
    }
    
    lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .vertical
        stk.distribution = .fill
        stk.alignment = .fill
        stk.spacing = 0
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    lazy var stackContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = Identity.color(.primary).cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: RichLabel = {
        let lbl = RichLabel()
        lbl.isHidden = true
        lbl.edgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        lbl.titleLabel.text = "Title Label"
        lbl.backgroundColor = backgroundColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    func sharedInit() {
        container.addSubview(stackContainer)
        stackContainer.addSubview(stackView)
        container.addSubview(titleLabel)
        contentView = container
    }
    
    public override func updateConstraints() {
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -20).isActive = true
        
        stackContainer.topAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        stackContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stackContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stackContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: stackContainer.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: stackContainer.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: stackContainer.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackContainer.bottomAnchor, constant: -10).isActive = true
        super.updateConstraints()
    }
    
    public func append(view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
