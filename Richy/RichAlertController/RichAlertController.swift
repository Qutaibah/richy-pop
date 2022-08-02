//
//  RichAlertController.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

public class RichAlertController: UIViewController {

	fileprivate var ui: RichAlertView!
    fileprivate var type: RichAlertController.Style!
	fileprivate var dismissable: Bool = false
    
    public override func loadView() {
		ui.delegate = self
		self.view = ui
	}

    public init(type: RichAlertController.Style, contents: [RichAlertController.ContentStyle], dismissable: Bool = false, insets: UIEdgeInsets = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)) {
        self.type = type
		super.init(nibName: nil, bundle: nil)
        let views = setupContentViews(contents: contents)
        switch type {
        case .alert, .actionSheet:
            self.ui = RichAlertRegularView(type: type, contents: views)
        case .popover:
            self.ui = RichAlertPopoverView(type: type, contents: views)
        }
        self.ui.edgeInsets = insets
        self.dismissable = dismissable
        setPresentationStyle()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}
    
    private func setPresentationStyle() {
        switch type {
        case .alert, .actionSheet:
            definesPresentationContext = true
            modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        case .popover(let source):
            modalPresentationStyle = .popover
            popoverPresentationController?.permittedArrowDirections = [.up, .down]
            popoverPresentationController?.delegate = self
            switch source {
            case .rect(let rect, let view):
                popoverPresentationController?.sourceView = view
                popoverPresentationController?.sourceRect = rect
            case .barButton(let item):
                popoverPresentationController?.barButtonItem = item
            }
        case .none:
            break
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        self.preferredContentSize = ui.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize,
                                                               withHorizontalFittingPriority: .defaultLow,
                                                               verticalFittingPriority: .defaultLow)
        ui.animateView()
	}
    
    private func setupContentViews(contents: [ContentStyle]) -> [UIView] {
        var views: [UIView] = []
        for item in contents {
            if case let .actions(buttons) = item {
                let view = ActionsView(actions: buttons, didTap: { [weak self] (_) in
                    self?.dismiss(animated: true, completion: nil)
                })
                views.append(view)
                continue
            }
            views.append(item.view)
        }
        return views
    }
}

extension RichAlertController: RichAlertViewDelegate {

	func didTapBackground(from view: RichAlertView) {
		if dismissable {
			self.dismiss(animated: true, completion: nil)
		}
	}
}

public extension RichAlertController {
    
    static func alert(icon: RichAlertController.ImageSource? = nil, title: String? = nil, message: String? = nil, confirm: String? = nil) -> UIViewController {
        general(icon: nil, title: title, message: message, approve: confirm, decline: nil, completion: nil, style: .primary)
    }
    
    static func prompt(icon: RichAlertController.ImageSource? = nil, title: String? = nil, message: String? = nil, approve: String? = nil, decline: String? = nil, completion: ((Bool) -> Void)? = nil) -> UIViewController {
        general(icon: icon, title: title, message: message, approve: approve, decline: decline, completion: completion, style: .primary)
    }
    
    static func destructive(icon: RichAlertController.ImageSource? = nil, title: String? = nil, message: String? = nil, approve: String? = nil, decline: String? = nil, completion: ((Bool) -> Void)? = nil) -> UIViewController {
        general(icon: icon, title: title, message: message, approve: approve, decline: decline, completion: completion, style: .destructive)
    }
    
    private static func general(icon: RichAlertController.ImageSource?, title: String?, message: String?, approve: String?, decline: String?, completion: ((Bool) -> Void)?, style: RichButton.Style) -> UIViewController {
        var styles: [RichAlertController.ContentStyle] = []
        if let icon = icon {
            styles.append(.icon(icon, insets: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)))
        }
        if let title = title {
            styles.append(.title(title, insets: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)))
        }
        if let message = message {
            styles.append(.text(message, insets: UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)))
        }
        var actions: [RichButton] = []
        if let decline = decline {
            let btnDecline = RichButton(type: .filled(.secondary), title: decline) { (button) in
                completion?(false)
            }
            actions.append(btnDecline)
        }
        if let approve = approve {
            let btnApprove = RichButton(type: .filled(style), title: approve) { (button) in
                completion?(true)
            }
            actions.append(btnApprove)
        }
        if actions.count > 0 {
            styles.append(.actions(buttons: actions))
        }
        return RichAlertController(type: .alert, contents: styles, dismissable: false)
    }
}
