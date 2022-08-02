//
//  UIView+Shadow.swift
//  Materials
//
//  Created by Qutaibah Essa on 08/10/2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

extension UIView {
    
    /// SwifterSwift: Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = .black,
                   radius: CGFloat = 3,
                   offset: CGSize = CGSize(width: 0, height: 3),
                   opacity: Float = 0.2) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
