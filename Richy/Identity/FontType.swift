//
//  FontType.swift
//  HungerStation
//
//  Created by Qutaibah Essa on 11/11/2018.
//  Copyright © 2018 Hunger_Station. All rights reserved.
//

import UIKit


/// Preset fonts for the app
///
/// - h1: size: 20, weight: bold
/// - h2: size: 18, weight: bold
/// - h3: size: 17, weight: bold
/// - h4: size: 17, weight: regular
/// - h5: size: 16, weight: regular
/// - h6: size: 15, weight: regular
/// - description: size: 14, weight: regular
/// - highlightedDescription: size: 14, weight: bold
/// - highlightedCaption: size: 13, weight: bold
/// - caption: size: 13, weight: regular
/// - highlightedBadge: size: 10, weight: bold
/// - badge: size: 10, weight: regular
/// - custom: set font for a custom size and weight
/// - old: for old views to keep the font pattern of Helvatica with a custom size
public enum FontType {
	/// size: 20, weight: bold
	case h1
	/// size: 18, weight: bold
	case h2
	/// size: 17, weight: bold
	case h3
	/// size: 17, weight: regular
	case h4
	/// size: 16, weight: regular
	case h5
	/// size: 15, weight: regular
	case h6
	/// size: 14, weight: regular
	case description
	/// size: 14, weight: bold
	case highlightedDescription
	/// size: 13, weight: bold
	case highlightedCaption
	/// size: 13, weight: regular
	case caption
	/// size: 10, weight: bold
	case highlightedBadge
	/// size: 10, weight: regular
	case badge
	/// set font for a custom size and weight
	case custom(weight: Font, size: CGFloat)
    /// monospace font for counting text
    case counter(weight: UIFont.Weight, size: CGFloat)

	public var font: UIFont {
		switch self {
		case .h1:
			return Font.bold.name.withSize(20)
		case .h2:
			return Font.bold.name.withSize(18)
		case .h3:
			return Font.bold.name.withSize(17)
		case .h4:
			return Font.regular.name.withSize(17)
		case .h5:
			return Font.regular.name.withSize(16)
		case .h6:
			return Font.regular.name.withSize(15)
		case .highlightedDescription:
			return Font.bold.name.withSize(14)
		case .description:
			return Font.regular.name.withSize(14)
		case .highlightedCaption:
			return Font.bold.name.withSize(13)
		case .caption:
			return Font.regular.name.withSize(13)
		case .highlightedBadge:
			return Font.bold.name.withSize(10)
		case .badge:
			return Font.regular.name.withSize(10)
		case .custom(let weight, let size):
			return weight.name.withSize(size)
        case .counter(let weight, let size):
            return Font.monospace(weight).name.withSize(size)
		}
	}
}
