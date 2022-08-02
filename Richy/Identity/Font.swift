//
//  Font.swift
//  HungerStation
//
//  Created by Qutaibah Essa on 11/11/2018.
//  Copyright © 2018 Hunger_Station. All rights reserved.
//

import UIKit

public enum Font {
	case bold
	case regular
	case light
	case black
    case medium
    case monospace(UIFont.Weight)

	var name: UIFont {
		switch self {
		case .bold:
			return UIFont.boldSystemFont(ofSize: 21)
		case .black:
			return UIFont.boldSystemFont(ofSize: 21)
		case .regular:
            return UIFont.systemFont(ofSize: 21, weight: .regular)
        case .light:
            return UIFont.systemFont(ofSize: 21, weight: .light)
        case .medium:
            return UIFont.systemFont(ofSize: 21, weight: .medium)
        case .monospace(let weight):
            return UIFont.monospacedDigitSystemFont(ofSize: 21, weight: weight)
		}
	}
}

//Helvetica Neue ["HelveticaNeue-UltraLightItalic", "HelveticaNeue-Medium", "HelveticaNeue-MediumItalic", "HelveticaNeue-UltraLight", "HelveticaNeue-Italic", "HelveticaNeue-Light", "HelveticaNeue-ThinItalic", "HelveticaNeue-LightItalic", "HelveticaNeue-Bold", "HelveticaNeue-Thin", "HelveticaNeue-CondensedBlack", "HelveticaNeue", "HelveticaNeue-CondensedBold", "HelveticaNeue-BoldItalic"]

//SF UI Text ["SFUIText-Medium", "SFUIText-Regular"]
//SF Pro Text ["SFProText-Medium", "SFProText-Bold", "SFProText-Regular"]
//SF UI Display ["SFUIDisplay-Bold", "SFUIDisplay-Medium", "SFUIDisplay-Light"]
//SF Pro Display ["SFProDisplay-Semibold"]
