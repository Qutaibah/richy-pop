//
//  RichButton+Types.swift
//  Richy
//
//  Created by Qutaibah Essa on 17/04/2020.
//  Copyright © 2020 Richy All rights reserved.
//

import UIKit

public extension RichButton {
    
    struct Shadow {
        public static var `default` = Shadow(color: UIColor.black.withAlphaComponent(0.3), radius: 3, offset: CGSize(width: 0, height: 2), opacity: 0.5)
        var color: UIColor
        var radius: CGFloat
        var offset: CGSize
        var opacity: Float
    }
    
    enum ButtonType {
        case filled(_ style: Style)
        case bordered(_ style: Style)
        case clear(_ style: Style)
        case custom(background: UIColor, content: UIColor, border: UIColor?)
    }
    
    enum HighlightingEffect {
        case none
        case system
    }
    
    enum Semantic {
        case `default`
        case reversed
        case forceLeftToRight
        case forceRightToLeft
    }

    enum Style {
        case primary
        case secondary
        case destructive
        
        var color: UIColor {
            switch self {
            case .primary:
                return Identity.color(.primary)
            case .secondary:
                return Identity.color(.grayBackground)
            case .destructive:
                return Identity.color(.red)
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .primary:
                return Identity.color(.white)
            case .secondary:
                return Identity.color(.darkGray)
            case .destructive:
                return Identity.color(.white)
            }
        }
    }
}
