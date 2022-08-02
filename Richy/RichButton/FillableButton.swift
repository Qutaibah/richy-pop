//
//  FillableButton.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

public class FillableButton: RichButton {

    private var style: Style!
    private var animationLayer = CAShapeLayer()
    private lazy var animationBackView: RandomContourView = {
        let view = RandomContourView(frame: bounds, color: style.color)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            animationBlock()
        }
    }

    public init(title: String? = nil, image: UIImage? = nil, semantic: RichButton.Semantic = .default, style: Style, contentInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), actionHandler: ((FillableButton) -> Void)? = nil) {
        super.init(type: .bordered(style), title: title, image: image, semantic: semantic, contentInset: contentInset, actionHandler: { (button) in
            guard let button = button as? FillableButton else { return }
            actionHandler?(button)
        })
        self.style = style
        borderView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func animationBlock(completion: (() -> Void)? = nil) {
        updateUI()
    }
    
    private func setupRandomizedAnimationLayer() {
        if animationBackView.superview != nil { animationBackView.removeFromSuperview() }
        animationBackView = RandomContourView(frame: bounds, color: style.color)
        animationBackView.isUserInteractionEnabled = false
        borderView.insertSubview(animationBackView, at: 0)
        if isSelected {
            animationBackView.transform = CGAffineTransform(scaleX: 0.000001, y: 0.000001)
        } else {
            animationBackView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    private func updateUI() {
        setupRandomizedAnimationLayer()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            [weak self] in
            if self?.isSelected == true {
                self?.animationBackView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self?.titleLabel.textColor = self?.style.textColor
            } else {
                self?.animationBackView.transform = CGAffineTransform(scaleX: 0.000001, y: 0.000001)
                self?.titleLabel.textColor = self?.style.color
            }
        })
    }
}
