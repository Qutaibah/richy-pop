//
//  RichyBottomSheetController.swift
//  Richy
//
//  Created by Irakli Vashakidze on 6/8/20.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

public class RichBottomSheet: UIViewController {
    
    // MARK: Declarations
    private(set) var viewController: UIViewController!
    private var displayMode = RichBottomSheetDisplayMode.halfScreen
    private var animationDuration: TimeInterval = 0.4
    private var bottomSheetTitle: String = ""
    
    private var containerTopAnchor: NSLayoutConstraint!
    private var containerHeightAnchor: NSLayoutConstraint!
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var childContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let bundle = Bundle.init(for: RichBottomSheet.self)
        button.setImage(UIImage(named: "close", in: bundle, compatibleWith: nil), for: .normal)
        button.tintColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Identity.font(.custom(weight: .medium, size: 15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
// MARK: Initialization
    public init(with viewController: UIViewController,
         animationDuration: TimeInterval = 0.4,
         title: String = "",
         displayMode: RichBottomSheetDisplayMode = .halfScreen) {
        super.init(nibName: nil, bundle: nil)
        self.animationDuration = animationDuration
        self.bottomSheetTitle = title
        self.displayMode = displayMode
        self.viewController = viewController
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSheet)))
        layout()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        container.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
// MARK:
    @objc private func dismissSheet() {
        self.animate(show: false, completion: {
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    private func layout() {
        self.alignContainer()
        self.alignXButton()
        self.alignLabel()
        self.alignChildContainer()
    }
    
    private func animate(show: Bool = true, completion: (()->Void)? = nil) {
        self.containerTopAnchor.isActive = !show
        UIView.animate(withDuration: self.animationDuration, animations: {
            let timingFunction = CAMediaTimingFunction.init(controlPoints: 0.25, 0.85, 0.55, 1)
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(timingFunction)
            self.view.layoutIfNeeded()
            self.childContainer.alpha = show ? 1 : 0
            self.view.backgroundColor = show ? UIColor.black.withAlphaComponent(0.3) : .clear
            CATransaction.commit()
        }, completion: {(_) in
            completion?()
        })
    }
}

// MARK: Layout
extension RichBottomSheet {
    
    private func alignContainer() {
        self.view.addSubview(container)
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.containerTopAnchor = container.topAnchor.constraint(equalTo: view.bottomAnchor)
        self.containerTopAnchor.isActive = true
        
        if !self.displayMode.isCustom {
            containerHeightAnchor = container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: self.displayMode.ratio ?? 1)
            containerHeightAnchor.constant = self.displayMode.constant
        } else {
            containerHeightAnchor = container.heightAnchor.constraint(equalToConstant: self.displayMode.customHeight)
        }
        containerHeightAnchor.isActive = true
        
        let containerBottomAnchor = container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerBottomAnchor.priority = UILayoutPriority(rawValue: 999)
        containerBottomAnchor.isActive = true
    }
    
    public func updateContainerHeight(height:CGFloat) {
        var constraintValue:CGFloat = height
        if self.displayMode.isCustom {
            self.displayMode = .custom(height: height)
            constraintValue = self.displayMode.customHeight
            UIView.animate(withDuration: 0.4, animations: {
                let timingFunction = CAMediaTimingFunction.init(controlPoints: 0.25, 0.85, 0.55, 1)
                CATransaction.begin()
                CATransaction.setAnimationTimingFunction(timingFunction)
                self.containerHeightAnchor.constant = constraintValue
                self.view.layoutIfNeeded()
                CATransaction.commit()
            }) { (complete) in
                if complete {
                    
                }
            }
        }
    }
    
    private func alignXButton() {
        container.addSubview(closeButton)
        let trailing = closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        trailing.constant = -8
        trailing.isActive = true
        
        let top = closeButton.topAnchor.constraint(equalTo: container.topAnchor)
        top.constant = 8
        top.isActive = true
        
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    private func alignLabel() {
        self.titleLabel.text = bottomSheetTitle
        container.addSubview(titleLabel)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        leading.constant = 16
        leading.isActive = true
        
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor)
        trailing.constant = -16
        trailing.isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: closeButton.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: closeButton.bottomAnchor).isActive = true
    }
    
    private func alignChildContainer() {
        container.addSubview(childContainer)
        let top = childContainer.topAnchor.constraint(equalTo: closeButton.bottomAnchor)
        top.constant = 8
        top.isActive = true
        
        childContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        childContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        let bottom = childContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottom.constant = -UIDevice.bottomNotchHeight // Additional padding
        bottom.isActive = true
        
        self.addChild(self.viewController)
        self.viewController.view.translatesAutoresizingMaskIntoConstraints = false
        childContainer.addSubview(self.viewController.view)
        self.viewController.willMove(toParent: self)
        
        self.viewController.view.leadingAnchor.constraint(equalTo: childContainer.leadingAnchor).isActive = true
        self.viewController.view.trailingAnchor.constraint(equalTo: childContainer.trailingAnchor).isActive = true
        self.viewController.view.topAnchor.constraint(equalTo: childContainer.topAnchor).isActive = true
        self.viewController.view.bottomAnchor.constraint(equalTo: childContainer.bottomAnchor).isActive = true
    }
}
