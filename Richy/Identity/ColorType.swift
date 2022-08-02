//
//  ColorType.swift
//  HungerStation
//
//  Created by Qutaibah Essa on 11/11/2018.
//  Copyright © 2018 Hunger_Station. All rights reserved.
//

import UIKit

public enum ColorType {
	case primary
	case secondary
    case darkGray
    case lightGray
    case grayBackground
    case red
    case transparent
    case white

	public var color: UIColor {
		switch self {
		case .primary:
            return UIColor(red: 0.23, green: 0.39, blue: 0.51, alpha: 1.00)
		case .secondary:
			return UIColor(red: 0.89, green: 0.91, blue: 0.93, alpha: 1.00)
        case .darkGray:
            return UIColor(red: 0.35, green: 0.40, blue: 0.44, alpha: 1.00)
        case .lightGray:
            return UIColor(red: 0.48, green: 0.53, blue: 0.56, alpha: 1.00)
        case .grayBackground:
            return UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        case .red:
            return UIColor(red: 1.00, green: 0.36, blue: 0.40, alpha: 1.00)
        case .transparent:
            return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.25)
        case .white:
            return UIColor.white
		}
	}
}
