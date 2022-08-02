//
//  RichButton+Badgable.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

extension RichButton: Badgable {
    
    private static let labelTag = 635132
    
    var currentBadgeText: String {
        return (badgeView.viewWithTag(RichButton.labelTag) as? UILabel)?.text ?? ""
    }
    
    var badgeHeight: CGFloat {
        return 20
    }
    
    public func showBadge(text: String, color: UIColor = Identity.color(.red)) {
        setupBadgeView(withText: text, backgroundColor: color)
        animateBadge()
    }
    
    public func showBadge(count: Int, maxCount: Int = 9, color: UIColor = Identity.color(.red)) {
        guard count > 0 else {
            hideBadge()
            return
        }
        
        let text = count > maxCount ? "+\(maxCount)" : "\(count)"
        setupBadgeView(withText: text, backgroundColor: color)
        animateBadge()
    }
    
    public func hideBadge() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.badgeView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }) { _ in
            self.badgeView.removeFromSuperview()
        }
    }
    
    private func animateBadge() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.badgeView.transform = .identity
        })
    }
    
    private func setupBadgeView(withText text: String, backgroundColor: UIColor) {
        guard currentBadgeText != text else { return }
        badgeView.removeFromSuperview()
        badgeView.backgroundColor = backgroundColor
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Identity.color(.white)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.text = text
        label.textAlignment = .center
        label.tag = RichButton.labelTag
        
        badgeView.addSubview(label)
        addSubview(badgeView)
        
        label.topAnchor.constraint(equalTo: badgeView.topAnchor, constant: 2).isActive = true
        label.leadingAnchor.constraint(equalTo: badgeView.leadingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: -4).isActive = true
        label.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor, constant: -2).isActive = true
        let widthConstraint = badgeView.widthAnchor.constraint(equalToConstant: badgeHeight)
        widthConstraint.priority = .init(100)
        NSLayoutConstraint.activate([
            badgeView.topAnchor.constraint(equalTo: topAnchor, constant: -(badgeHeight/2.5)),
            badgeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: badgeHeight/2.5),
            badgeView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: badgeHeight/2.5),
            badgeView.heightAnchor.constraint(equalToConstant: badgeHeight),
            badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: badgeHeight),
            widthConstraint,
            ])
        
        badgeView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    }
}
