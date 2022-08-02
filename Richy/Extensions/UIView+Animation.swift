//
//  UIView+Animation.swift
//  Materials
//
//  Created by Qutaibah Essa on 08/10/2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

extension UIView {
    
    static func animateTrueCompletion(withDuration duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping dampingRatio: CGFloat = 1, initialSpringVelocity velocity: CGFloat = 0, options: UIView.AnimationOptions = [], animations: @escaping () -> Void, completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+duration+delay) {
            completion?()
        }
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: options, animations: animations, completion: nil)
    }
}

