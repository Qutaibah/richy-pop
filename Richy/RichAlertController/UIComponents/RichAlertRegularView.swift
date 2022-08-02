//
//  RichAlertRegularView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class RichAlertRegularView: RichAlertView {

    override var delegate: RichAlertViewDelegate? {
        didSet {
            setupComponents()
        }
    }

    private let type: RichAlertController.Style

    private var content: RichAlertContentView!

    private var contentHeightConstraint: NSLayoutConstraint?

    private lazy var tapListenerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(type: RichAlertController.Style, contents: [UIView]) {
        self.type = type
        super.init(type: type, contents: contents)
        content = RichAlertContentView(views: contents)
        switch type {
        case .alert:
            content.edgeInsets = edgeInsets
        case .actionSheet:
            var safeArea: CGFloat = 0
            if #available(iOS 11.0, *) {
                safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            }
            let bottom = safeArea + edgeInsets.bottom
            content.edgeInsets = UIEdgeInsets(top: edgeInsets.top, left: edgeInsets.left, bottom: bottom, right: edgeInsets.right)
        case .popover:
            break
        }
        content.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(_:)))
        tapListenerView.addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupComponents() {
        backgroundColor = .clear
        addSubview(tapListenerView)
        addSubview(content)
    }
    
    private func setupConstraints() {
        switch type {
        case .alert:
            content.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            content.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            content.topAnchor.constraint(greaterThanOrEqualTo: topAnchor,
                                             constant: 30).isActive = true
            content.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor,
                                                 constant: 20).isActive = true
        case .actionSheet:
            content.anchor(bottom: bottomAnchor,
                               bottomConstant: -15)
            content.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        case .popover:
            break
        }

        tapListenerView.anchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: trailingAnchor)
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHeightConstraint?.isActive = false
        if UIScreen.main.bounds.width > 500 {
            contentHeightConstraint = NSLayoutConstraint(item: content!,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 0,
                                            constant: type == .alert ? 330 : 410)
        } else {
            contentHeightConstraint = NSLayoutConstraint(item: content!,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .width,
                                            multiplier: type == .alert ? 0.8 : 1,
                                            constant: 0)
        }
        contentHeightConstraint?.isActive = true
    }
    
    @objc private func didTapBackground(_ sender: UITapGestureRecognizer) {
        if sender.view != content {
            delegate?.didTapBackground(from: self)
        }
    }

    override func animateView() {
        super.animateView()
        content.animateView()
    }
}
