//
//  Identity.swift
//  HungerStation
//
//  Created by Qutaibah Essa on 09/06/2018.
//  Copyright © 2018 Hunger_Station. All rights reserved.
//

import UIKit

public struct Identity {

	public static func font(_ type: FontType) -> UIFont {
		return type.font
	}

	public static func color(_ type: ColorType) -> UIColor {
		return type.color
	}
    
    public static var safeTopSpace: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            return topPadding ?? 20
        }
        return 20
    }

	public static var safeBottomSpace: CGFloat {
		if #available(iOS 11.0, *) {
			let window = UIApplication.shared.keyWindow
			let bottomPadding = window?.safeAreaInsets.bottom
			return bottomPadding ?? 0
		}
		return 0
	}

	public struct margin {
		enum horizontal: CGFloat {
			case level1 = 5
			case level2 = 10
			case level3 = 15
			case superview = 24
		}
	}
}

