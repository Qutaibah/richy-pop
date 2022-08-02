//
//  ActionsView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class ActionsView: BaseView {

	private var didTap: ((ActionsView) -> Void)?
    
	private lazy var stackView: UIStackView = {
		let stk = UIStackView()
		stk.axis = .horizontal
		stk.alignment = .fill
		stk.distribution = .fillEqually
		stk.spacing = 16
		stk.translatesAutoresizingMaskIntoConstraints = false
		return stk
	}()

	init(actions: [RichButton], didTap: ((ActionsView) -> Void)?) {
		super.init(frame: CGRect.zero)
		self.didTap = didTap
        var shouldShowVerticalActions: Bool = actions.count > 2
        
		for action in actions {
            action.heightAnchor.constraint(equalToConstant: Identity.Dimension.alertActionHeight).isActive = true
			stackView.addArrangedSubview(action)
            if (action.title?.count ?? 0) > 12 {
                shouldShowVerticalActions = true
            }
		}
        
		if shouldShowVerticalActions {
            let views = stackView.arrangedSubviews.reversed()
            stackView.arrangedSubviews.forEach({ stackView.removeArrangedSubview($0) })
            views.forEach({ stackView.addArrangedSubview($0) })
			stackView.axis = .vertical
            stackView.spacing = 12
			stackView.distribution = .fillProportionally
		}
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
		tap.delegate = self
		addGestureRecognizer(tap)
        edgeInsets = .zero
        contentView = stackView
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

	@objc private func didTapAction() {
		didTap?(self)
	}
}

extension ActionsView: UIGestureRecognizerDelegate {

	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
